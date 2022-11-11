import 'package:berhentikok/base/duration_extension.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/model/health_progress.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/health/widget/linear_indicator.dart';
import 'package:berhentikok/widget/card_widget/box_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthCardWidget extends StatelessWidget {
  final User user;
  final HealthProgress? healthProgress;
  final List<SmokingDetail> smokingDetails;
  final Duration freeSmokingDuration;
  final Color? linearValueColor;
  final Color? backgroundColor;
  final Color? textColor;
  const HealthCardWidget({
    Key? key,
    required this.healthProgress,
    required this.smokingDetails,
    required this.user,
    required this.freeSmokingDuration,
    this.linearValueColor,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (healthProgress == null) return const SizedBox();
    return BoxCardWidget(
      backgroundColor: backgroundColor,
      child: Row(
        children: [
          Image.asset(
            healthProgress!.imageFile,
            width: 40.w,
          ),
          SizedBox(width: 24.w),
          Expanded(
            child: Column(
              children: [
                Text(
                  healthProgress!.caption,
                  style: FontConst.subtitle(
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                LinearIndicator(
                  valueColor: linearValueColor,
                  value: healthProgress!.value(
                    user: user,
                    smokingDetails: smokingDetails,
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildProgress(
                      healthProgress: healthProgress!,
                      freeSmokingDuration: freeSmokingDuration,
                    ),
                    SizedBox(width: 5.w),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgress({
    required HealthProgress healthProgress,
    required Duration freeSmokingDuration,
  }) {
    late String healthProgressDurationCaption;
    String smokingFreeDurationCaption = "";

    if (freeSmokingDuration.compareTo(healthProgress.endDuration) < 0) {
      smokingFreeDurationCaption = freeSmokingDuration.toStringDuration();
    }

    if (healthProgress.startDuration.compareTo(healthProgress.endDuration) ==
        0) {
      healthProgressDurationCaption =
          healthProgress.startDuration.toStringDuration();
    } else {
      healthProgressDurationCaption =
          "${healthProgress.startDuration.toStringDuration()} - ${healthProgress.endDuration.toStringDuration()}";
    }
    return Text(
      "${smokingFreeDurationCaption.isEmpty ? "" : "$smokingFreeDurationCaption / "}$healthProgressDurationCaption",
      style: FontConst.small(
        color: textColor ?? Colors.white,
      ),
    );
  }
}
