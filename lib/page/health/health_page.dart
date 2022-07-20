import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/model/health_progress.dart';
import 'package:berhentikok/page/health/widget/health_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({Key? key}) : super(key: key);

  static List<HealthProgress> healthProgresses = [
    const HealthProgress(
      icon: Icons.favorite,
      caption: 'Tekanan darah kembali normal',
      value: 50,
    ),
    const HealthProgress(
      icon: Icons.favorite,
      caption: 'Tekanan darah kembali normal',
      value: 50,
    ),
    const HealthProgress(
      icon: Icons.favorite,
      caption: 'Tekanan darah kembali normal',
      value: 50,
    ),
    const HealthProgress(
      icon: Icons.favorite,
      caption: 'Tekanan darah kembali normal',
      value: 50,
    ),
    const HealthProgress(
      icon: Icons.favorite,
      caption: 'Tekanan darah kembali normal',
      value: 50,
    ),
    const HealthProgress(
      icon: Icons.favorite,
      caption: 'Tekanan darah kembali normal',
      value: 50,
    ),
    const HealthProgress(
      icon: Icons.favorite,
      caption: 'Tekanan darah kembali normal',
      value: 50,
    ),
    const HealthProgress(
      icon: Icons.favorite,
      caption: 'Tekanan darah kembali normal',
      value: 50,
    ),
    const HealthProgress(
      icon: Icons.favorite,
      caption: 'Tekanan darah kembali normal',
      value: 50,
    ),
    const HealthProgress(
      icon: Icons.favorite,
      caption: 'Tekanan darah kembali normal',
      value: 50,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.darkGreen,
        title: const Text("Kesehatan"),
      ),
      body: ListView.builder(
        padding: SizeConst.pagePadding,
        itemCount: healthProgresses.length,
        itemBuilder: (context, index) {
          final HealthProgress healthProgress = healthProgresses[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: HealthCardWidget(healthProgress: healthProgress),
          );
        },
      ),
    );
  }
}
