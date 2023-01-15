import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/consumption/bloc/smoking_detail_bloc.dart';
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Container(
        decoration: const BoxDecoration(color: ColorConst.darkGreen),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 18.w,
            horizontal: 18.w,
          ),
          child: Row(
            children: [
              Icon(
                Icons.timer_outlined,
                color: Colors.white,
                size: 80.w,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kamu sudah tidak merokok selama",
                      style: FontConst.small(
                        color: ColorConst.lightGreen,
                      ),
                    ),
                    Text(
                      freeSmokingDurationCaption,
                      style: FontConst.header2(
                        color: Colors.white,
                        fontSize: 26.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
