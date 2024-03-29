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
      onTap: achievement.isAchieved ? onTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: achievement.isRead
              ? ColorConst.lightGreen
              : achievement.isAchieved
                  ? ColorConst.darkGreen
                  : Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Container(
              width: 45.w,
              height: 45.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(achievement.imageFile),
                    fit: BoxFit.contain,
                    colorFilter: achievement.isAchieved
                        ? null
                        : ColorFilter.mode(
                            Colors.black.withOpacity(0.2),
                            BlendMode.dstIn,
                          )),
              ),
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
                          : achievement.isAchieved
                              ? ColorConst.lightGreen
                              : Colors.black26,
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
