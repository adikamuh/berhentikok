import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmokingFreeTotalCardWidget extends StatelessWidget {
  final int total;
  const SmokingFreeTotalCardWidget({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: ColorConst.darkGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/ic-free-smoking.png',
              width: 40.w,
            ),
            SizedBox(width: 18.w),
            Text(
              "$total Batang rokok terhindari",
              style: FontConst.header3(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
