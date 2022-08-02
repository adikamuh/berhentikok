import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/model/achievement.dart';
import 'package:berhentikok/page/achievement/widget/achievement_card_widget.dart';
import 'package:berhentikok/page/achievement/widget/achievement_detail_dialog.dart';
import 'package:flutter/material.dart';

class AchievementPage extends StatelessWidget {
  final List<Achievement> achievements;
  const AchievementPage({
    Key? key,
    required this.achievements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onTap: achievement.isAchieved
                ? () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AchievementDetailDialog(
                            achievement: achievement);
                      },
                    );
                  }
                : null,
            achievement: achievement,
          );
        },
      ),
    );
  }
}
