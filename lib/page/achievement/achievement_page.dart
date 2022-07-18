import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/model/achievement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Achievement> achievements = [
      const Achievement(
        title: '7 Hari tanpa merokok!',
        description: "Kamu berhasil selama 7 hari bebas dari asap rokok",
        dialogDescription:
            "Kamu sudah berhasil selama 7 hari terbebas dari rokok. Lanjutkan kebiasaan baik ini!",
        icon: Icons.smoke_free,
      ),
      const Achievement(
        title: '7 Hari tanpa merokok!',
        description: "Kamu berhasil selama 7 hari bebas dari asap rokok",
        dialogDescription:
            "Kamu sudah berhasil selama 7 hari terbebas dari rokok. Lanjutkan kebiasaan baik ini!",
        icon: Icons.smoke_free,
      ),
      const Achievement(
        title: '7 Hari tanpa merokok!',
        description: "Kamu berhasil selama 7 hari bebas dari asap rokok",
        dialogDescription:
            "Kamu sudah berhasil selama 7 hari terbebas dari rokok. Lanjutkan kebiasaan baik ini!",
        icon: Icons.smoke_free,
      ),
      const Achievement(
        title: '7 Hari tanpa merokok!',
        description: "Kamu berhasil selama 7 hari bebas dari asap rokok",
        dialogDescription:
            "Kamu sudah berhasil selama 7 hari terbebas dari rokok. Lanjutkan kebiasaan baik ini!",
        icon: Icons.smoke_free,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievement"),
      ),
      body: ListView.builder(
        padding: SizeConst.pagePadding,
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final Achievement achievement = achievements[index];
          return InkWell(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 25.h,
                      ),
                      children: [
                        Icon(achievement.icon),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(achievement.title),
                            Text(
                              achievement.dialogDescription,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Oke"),
                        ),
                      ],
                    );
                  });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              margin: EdgeInsets.only(bottom: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: ColorConst.primaryColor1,
              ),
              child: Row(
                children: [
                  Icon(achievement.icon),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(achievement.title),
                        Text(achievement.description),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
