import 'package:berhentikok/base/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// [value] is 0-100
class LinearIndicator extends StatelessWidget {
  final int value;
  final Color? valueColor;
  final Color? backgroundColor;
  const LinearIndicator({
    super.key,
    required this.value,
    this.valueColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final widthValue = (value / 100) * width;
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (value < 100)
              Container(
                width: width,
                height: 5.h,
                decoration: BoxDecoration(
                  color: backgroundColor ?? ColorConst.lightGlowingGreen,
                  borderRadius: BorderRadius.circular(50.r),
                ),
              ),
            Row(
              children: [
                Container(
                  width: value >= 100 ? width : widthValue,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: valueColor ?? ColorConst.glowingGreen,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
