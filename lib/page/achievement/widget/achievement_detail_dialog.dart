import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/model/achievement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AchievementDetailDialog extends StatelessWidget {
  final Achievement achievement;
  const AchievementDetailDialog({Key? key, required this.achievement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 25.h,
      ),
      children: [
        Image.asset(
          achievement.imageFile,
          width: 45.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              achievement.title,
              textAlign: TextAlign.center,
              style: FontConst.header3(),
            ),
            SizedBox(height: 5.h),
            Text(
              achievement.dialogDescription,
              textAlign: TextAlign.center,
              style: FontConst.body(),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        ElevatedButton(
          style: ButtonStyleConst.secondary(),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Oke"),
        ),
      ],
    );
  }
}
