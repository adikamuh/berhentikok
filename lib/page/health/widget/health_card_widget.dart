import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/model/health_progress.dart';
import 'package:berhentikok/page/health/widget/linear_indicator.dart';
import 'package:berhentikok/widget/card_widget/box_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthCardWidget extends StatelessWidget {
  final HealthProgress healthProgress;
  const HealthCardWidget({Key? key, required this.healthProgress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BoxCardWidget(
      child: Row(
        children: [
          Icon(
            healthProgress.icon,
            size: 40.w,
            color: Colors.white,
          ),
          SizedBox(width: 24.w),
          Expanded(
            child: Column(
              children: [
                Text(
                  healthProgress.caption,
                  style: FontConst.subtitle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                LinearIndicator(value: healthProgress.value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
