import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/model/achievement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AchievementCardWidget extends StatelessWidget {
  final Achievement achievement;
  final Function()? onTap;
  const AchievementCardWidget({
    Key? key,
    required this.achievement,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color:
              achievement.isRead ? ColorConst.lightGreen : ColorConst.darkGreen,
        ),
        child: Row(
          children: [
            Image.asset(
              achievement.imageFile,
              width: 45.w,
            ),
            SizedBox(width: 18.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    achievement.title,
                    textAlign: TextAlign.center,
                    style: FontConst.subtitle(
                      color: achievement.isRead
                          ? ColorConst.darkGreen
                          : ColorConst.lightGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
