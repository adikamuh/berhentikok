import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionStatisticDetailWidget extends StatelessWidget {
  final String? title;
  final IconData? iconData;
  final bool? showBorder;
  final Color? backgroundColor;
  final Widget child;
  const SectionStatisticDetailWidget({
    Key? key,
    this.title,
    this.iconData,
    this.showBorder = true,
    this.backgroundColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius:
              showBorder ?? false ? BorderRadius.circular(16.r) : null,
          border: showBorder ?? false
              ? Border.all(
                  color: ColorConst.greyColor2.withOpacity(0.5),
                  width: 1.2,
                )
              : null),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Padding(
        padding: showBorder ?? false
            ? EdgeInsets.symmetric(vertical: 18.w, horizontal: 16.w)
            : EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Row(
                children: [
                  if (iconData != null) ...[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConst.darkGreen,
                      ),
                      child: Icon(
                        iconData,
                        color: ColorConst.lightGlowingGreen,
                        size: 16.w,
                      ),
                    ),
                    SizedBox(width: 10.w),
                  ],
                  Expanded(
                    child: Text(
                      title!,
                      style: FontConst.header3(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            if (title != null) SizedBox(height: 14.h),
            child,
          ],
        ),
      ),
    );
  }
}
