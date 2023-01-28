import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxCardWidget extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color outlineBorderColor;
  final bool showMoreCaption;

  const BoxCardWidget({
    Key? key,
    required this.child,
    this.backgroundColor,
    Color? outlineBorderColor,
    bool? showMoreCaption,
  })  : outlineBorderColor = outlineBorderColor ?? Colors.transparent,
        showMoreCaption = showMoreCaption ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
            color: outlineBorderColor,
            width: 2,
          )),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.only(
          top: 24.h,
          bottom: showMoreCaption ? 12.h : 24.h,
          left: 20.w,
          right: 20.w,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorConst.darkGreen,
        ),
        child: Column(
          children: [
            child,
            if (showMoreCaption) ...[
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Lihat semua",
                    style: FontConst.small(
                      fontWeight: FontWeight.normal,
                      color: ColorConst.darkGreen,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 10.w,
                    color: ColorConst.darkGreen,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
