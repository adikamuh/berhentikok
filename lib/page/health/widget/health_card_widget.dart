import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/duration_extension.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/model/health_progress.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/health/widget/linear_indicator.dart';
import 'package:berhentikok/widget/card_widget/box_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthCardWidget extends StatefulWidget {
  final User user;
  final HealthProgress healthProgress;
  final List<SmokingDetail> smokingDetails;
  final Duration freeSmokingDuration;
  final int value;
  final Color? linearValueColor;
  final Color? linearBackgroundColor;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOutlined;
  final bool showMoreCaption;

  HealthCardWidget({
    super.key,
    required this.healthProgress,
    required this.smokingDetails,
    required this.user,
    required this.freeSmokingDuration,
    this.linearValueColor,
    this.linearBackgroundColor,
    this.backgroundColor,
    this.textColor,
    bool? isOutlined,
    bool? showMoreCaption,
  }) : value = healthProgress.value(user: user, smokingDetails: smokingDetails),
       isOutlined = isOutlined ?? false,
       showMoreCaption = showMoreCaption ?? false;

  @override
  State<HealthCardWidget> createState() => _HealthCardWidgetState();
}

class _HealthCardWidgetState extends State<HealthCardWidget> {
  late bool isComplete;
  late bool isStarted;

  @override
  void initState() {
    super.initState();
    isComplete = widget.value >= 100;
    isStarted = widget.value > 0;
  }

  @override
  Widget build(BuildContext context) {
    return BoxCardWidget(
      showMoreCaption: widget.showMoreCaption,
      backgroundColor:
          widget.isOutlined
              ? Colors.transparent
              : widget.backgroundColor ??
                  (isComplete
                      ? ColorConst.darkGreen
                      : isStarted
                      ? ColorConst.lightGreen
                      : Colors.grey.shade200),
      outlineBorderColor: widget.isOutlined ? widget.backgroundColor : null,
      child: Column(
        children: [
          Row(
            children: [
              // SizedBox(width: 12.w),
              Image.asset(widget.healthProgress.imageFile, width: 40.w),
              SizedBox(width: 24.w),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      widget.healthProgress.caption,
                      style: FontConst.subtitle(
                        color:
                            widget.textColor ??
                            (isComplete
                                ? Colors.white
                                : isStarted
                                ? ColorConst.darkGreen
                                : Colors.grey.shade800),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: LinearIndicator(
                            valueColor:
                                widget.linearValueColor ??
                                (isComplete
                                    ? ColorConst.glowingGreen
                                    : isStarted
                                    ? ColorConst.darkGreen
                                    : Colors.grey.shade200),
                            backgroundColor:
                                widget.linearBackgroundColor ??
                                (isStarted ? null : Colors.grey.shade300),
                            value: widget.value,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildProgress(
                          healthProgress: widget.healthProgress,
                          freeSmokingDuration: widget.freeSmokingDuration,
                        ),
                        _buildPercentage(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 16.h),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [],
          // ),
        ],
      ),
    );
  }

  Widget _buildPercentage() {
    return Text(
      "${widget.value}%",
      style: FontConst.small(
        color:
            isComplete
                ? Colors.white
                : isStarted
                ? ColorConst.darkGreen
                : Colors.grey.shade800,
      ),
    );
  }

  Widget _buildProgress({
    required HealthProgress healthProgress,
    required Duration freeSmokingDuration,
  }) {
    final difference = healthProgress.endDuration - freeSmokingDuration;
    return Text(
      difference.inSeconds >= 0 ? "${difference.toStringDuration()} lagi" : "",
      style: FontConst.small(
        color:
            isComplete
                ? Colors.white
                : isStarted
                ? ColorConst.darkGreen
                : Colors.grey.shade800,
      ),
    );
    // late String healthProgressDurationCaption;
    // String smokingFreeDurationCaption = "";

    // if (freeSmokingDuration.compareTo(healthProgress.endDuration) < 0) {
    //   smokingFreeDurationCaption = freeSmokingDuration.toStringDuration();
    // }

    // if (healthProgress.startDuration.compareTo(healthProgress.endDuration) ==
    //     0) {
    //   healthProgressDurationCaption =
    //       healthProgress.startDuration.toStringDuration();
    // } else {
    //   healthProgressDurationCaption =
    //       "${healthProgress.startDuration.toStringDuration()} - ${healthProgress.endDuration.toStringDuration()}";
    // }
    // return Text(
    //   "${smokingFreeDurationCaption.isEmpty ? "" : "$smokingFreeDurationCaption / "}$healthProgressDurationCaption",
    //   style: FontConst.small(color: textColor ?? Colors.white),
    // );
  }
}
