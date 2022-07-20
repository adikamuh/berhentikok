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
          color: ColorConst.lightGreen,
        ),
        child: Row(
          children: [
            Icon(
              achievement.icon,
              size: 45.w,
              color: ColorConst.darkGreen,
            ),
            SizedBox(width: 18.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.title,
                    style: FontConst.subtitle(
                      color: ColorConst.darkGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    achievement.description,
                    style: FontConst.body(
                      color: ColorConst.darkGreen,
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
