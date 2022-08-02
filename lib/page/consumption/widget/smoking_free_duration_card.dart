import 'dart:async';

import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/consumption/bloc/consumption_bloc.dart';
import 'package:berhentikok/page/consumption/widget/add_smoking_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmokingFreeDurationCard extends StatefulWidget {
  final User user;
  final List<SmokingDetail> smokingDetails;
  const SmokingFreeDurationCard({
    Key? key,
    required this.user,
    required this.smokingDetails,
  }) : super(key: key);

  @override
  State<SmokingFreeDurationCard> createState() =>
      _SmokingFreeDurationCardState();
}

class _SmokingFreeDurationCardState extends State<SmokingFreeDurationCard> {
  late StreamSubscription _streamSubscription;
  String? _durationFreeSmoking = "";

  @override
  void initState() {
    _streamSubscription = widget.user
        .sumFreeSmokingDuration(widget.smokingDetails)
        .listen((duration) {
      setState(() {
        _durationFreeSmoking = duration;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConsumptionBloc, ConsumptionState>(
      listener: (context, state) {
        if (state is ConsumptionLoaded) {
          _streamSubscription = widget.user
              .sumFreeSmokingDuration(state.smokingDetails)
              .listen((duration) {
            setState(() {
              _durationFreeSmoking = duration;
            });
          });
        }
      },
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    if (_durationFreeSmoking == null) {
      return Card(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        elevation: 0,
        margin: EdgeInsets.zero,
        color: ColorConst.lightGreen,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.w),
          child: Text(
            "Yahh, sayang sekali kamu belum mulai berhenti merokok nih :(",
            style: FontConst.header3(
              color: ColorConst.darkRed,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      );
    } else {
      return Card(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
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
                            _durationFreeSmoking!,
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
}
