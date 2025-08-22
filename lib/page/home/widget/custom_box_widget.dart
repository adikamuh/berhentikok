import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBoxWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color outlineBorderColor;
  final Color iconColor;
  final Color textColor;
  final Function() onTap;

  const CustomBoxWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.backgroundColor,
    Color? outlineBorderColor,
    required this.iconColor,
    required this.textColor,
    required this.onTap,
  }) : outlineBorderColor = outlineBorderColor ?? Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: outlineBorderColor, width: 2),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 35.w, color: iconColor),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      text,
                      style: FontConst.body(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: textColor,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 25.w,
                    color: ColorConst.darkGreen,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
