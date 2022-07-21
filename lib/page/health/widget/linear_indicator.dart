import 'package:berhentikok/base/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// [value] is 0-100
class LinearIndicator extends StatelessWidget {
  final int value;
  const LinearIndicator({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5.h,
          decoration: BoxDecoration(
            color: ColorConst.lightGlowingGreen,
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: value,
              child: Container(
                width: double.infinity,
                height: 5.h,
                decoration: BoxDecoration(
                  color: ColorConst.glowingGreen,
                  borderRadius: BorderRadius.circular(50.r),
                ),
              ),
            ),
            Expanded(
              flex: 100 - value,
              child: const SizedBox(width: double.infinity),
            ),
            // Expanded(
            //   flex: 100 - value,
            // ),
          ],
        ),
      ],
    );
  }
}
