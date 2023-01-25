import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/model/health_progress.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/health/widget/health_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:round_spot/round_spot.dart';

class HealthPage extends StatelessWidget {
  final List<HealthProgress> healthProgresses;
  final List<SmokingDetail> smokingDetails;
  final User user;
  const HealthPage({
    Key? key,
    required this.healthProgresses,
    required this.smokingDetails,
    required this.user,
  }) : super(key: key);

  static const routeName = 'health';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.darkGreen,
        title: const Text("Kesehatan"),
      ),
      body: Detector(
        areaID: 'health',
        child: ListView.builder(
          padding: SizeConst.pagePadding,
          itemCount: healthProgresses.length,
          itemBuilder: (context, index) {
            final Duration freeSmokingDuration =
                smokingDetails.freeSmokingDuration(user);
            final HealthProgress healthProgress = healthProgresses[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: HealthCardWidget(
                healthProgress: healthProgress,
                smokingDetails: smokingDetails,
                user: user,
                freeSmokingDuration: freeSmokingDuration,
              ),
            );
          },
        ),
      ),
    );
  }
}
