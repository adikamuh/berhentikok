import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoneySavedCardWidget extends StatelessWidget {
  final String value;
  const MoneySavedCardWidget({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: ColorConst.darkGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/ic-savings.png',
              width: 40.w,
            ),
            SizedBox(width: 18.w),
            Text(
              value,
              style: FontConst.header3(
                fontSize: 30.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
