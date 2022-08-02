import 'package:berhentikok/base/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// [value] is 0-100
class LinearIndicator extends StatelessWidget {
  final int value;
  final Color? valueColor;
  const LinearIndicator({
    Key? key,
    required this.value,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = 270.w;
    final _widthValue = (value / 100) * _width;
    return Stack(
      alignment: Alignment.center,
      children: [
        if (value < 100)
          Container(
            width: _width,
            height: 5.h,
            decoration: BoxDecoration(
              color: ColorConst.lightGlowingGreen,
              borderRadius: BorderRadius.circular(50.r),
            ),
          ),
        Row(
          children: [
            Container(
              width: value >= 100 ? _width : _widthValue,
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
  }
}
