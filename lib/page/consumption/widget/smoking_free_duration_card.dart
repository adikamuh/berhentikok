import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/consumption/bloc/consumption_bloc.dart';
import 'package:berhentikok/page/consumption/bloc/smoking_detail_bloc.dart';
import 'package:berhentikok/page/consumption/widget/add_smoking_detail_dialog.dart';
import 'package:berhentikok/page/finance/bloc/finance_bloc.dart';
import 'package:berhentikok/page/health/bloc/health_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmokingFreeDurationCard extends StatefulWidget {
  final User user;
  const SmokingFreeDurationCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<SmokingFreeDurationCard> createState() =>
      _SmokingFreeDurationCardState();
}

class _SmokingFreeDurationCardState extends State<SmokingFreeDurationCard> {
  late SmokingDetailBloc smokingDetailBloc;

  @override
  void initState() {
    smokingDetailBloc = context.read<SmokingDetailBloc>()
      ..add(LoadSmokingDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmokingDetailBloc, Resource<SmokingDetailState>>(
      bloc: smokingDetailBloc,
      builder: (context, state) {
        if (state is Success) {
          final List<SmokingDetail> smokingDetails = state
                  .inferredData?.smokingDetailsMap.values
                  .fold<List<SmokingDetail>>(
                [],
                (previousValue, curValue) => previousValue + curValue,
              ) ??
              [];

          return StreamBuilder(
            stream: widget.user.sumFreeSmokingDuration(smokingDetails),
            builder: (context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return _buildCard(snapshot.data!);
              }
              return const SizedBox();
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildCard(String freeSmokingDurationCaption) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Container(
        decoration: const BoxDecoration(color: ColorConst.darkGreen),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 18.w,
                horizontal: 18.w,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 180.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kamu sudah berhenti merokok selama",
                          style: FontConst.body(color: ColorConst.lightGreen),
                        ),
                        SizedBox(height: 18.h),
                        Text(
                          freeSmokingDurationCaption,
                          style: FontConst.header1(
                            color: Colors.white,
                            fontSize: 30.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.timer_outlined,
                    color: const Color(0xff589370),
                    size: 100.w,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 25.h,
                      ),
                      children: [AddSmokingDetailDialog(user: widget.user)],
                    );
                  },
                );
                context.read<HealthBloc>().add(LoadHealth());
                context.read<FinanceBloc>().add(LoadFinance());
                context.read<ConsumptionBloc>().add(LoadConsumption());
              },
              child: Container(
                color: ColorConst.lightGreen,
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Saya merokok lagi hari ini ",
                      style: FontConst.body(
                        color: ColorConst.darkRed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(
                      Icons.sentiment_dissatisfied,
                      color: ColorConst.darkRed,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
