import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LongCardWidget extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isSuffixIconOn;
  final Function()? onTap;
  const LongCardWidget({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.isSuffixIconOn = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorConst.primaryColor1,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: FontConst.subtitle(
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (isSuffixIconOn)
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: textColor ?? Colors.white,
                )
            ],
          ),
        ),
      ),
    );
  }
}
