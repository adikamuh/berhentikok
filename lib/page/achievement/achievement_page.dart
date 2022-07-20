import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/model/achievement.dart';
import 'package:berhentikok/page/achievement/widget/achievement_card_widget.dart';
import 'package:berhentikok/page/achievement/widget/achievement_detail_dialog.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: ColorConst.darkGreen,
      ),
      body: ListView.builder(
        padding: SizeConst.pagePadding,
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final Achievement achievement = achievements[index];
          return AchievementCardWidget(
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return AchievementDetailDialog(achievement: achievement);
                },
              );
            },
            achievement: achievement,
          );
        },
      ),
    );
  }
}
