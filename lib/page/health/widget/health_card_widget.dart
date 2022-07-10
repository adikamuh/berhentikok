import 'package:berhentikok/base/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthCardWidget extends StatelessWidget {
  final IconData iconData;
  final String caption;
  final double progressValue;
  const HealthCardWidget({
    Key? key,
    required this.iconData,
    required this.caption,
    required this.progressValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: ColorConst.primaryColor1,
      ),
      child: Row(
        children: [
          Icon(iconData),
          Expanded(
            child: Column(
              children: [
                Text(caption),
                LinearProgressIndicator(value: progressValue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
