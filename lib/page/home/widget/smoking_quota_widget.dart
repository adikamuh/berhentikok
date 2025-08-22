import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmokingQuotaWidget extends StatelessWidget {
  final int smokingQuota;
  const SmokingQuotaWidget({super.key, required this.smokingQuota});

  @override
  Widget build(BuildContext context) {
    if (smokingQuota > 0) {
      return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(color: Colors.yellow.shade500),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 18.w, horizontal: 18.w),
            child: Row(
              children: [
                Icon(
                  Icons.smoking_rooms_rounded,
                  color: Colors.black,
                  size: 80.w,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Batas konsumsi rokokmu hari ini",
                        style: FontConst.small(color: Colors.black),
                      ),
                      Text(
                        "$smokingQuota Rokok",
                        style: FontConst.header2(
                          color: Colors.black,
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
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Container(
        decoration: const BoxDecoration(color: ColorConst.darkRed),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.w, horizontal: 18.w),
          child: Row(
            children: [
              Icon(
                Icons.sentiment_dissatisfied_rounded,
                color: Colors.white,
                size: 80.w,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Yah kamu sudah melewati batas konsumsi rokokmu hari ini!",
                      style: FontConst.header3(
                        color: Colors.white,
                        fontSize: 18.sp,
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
