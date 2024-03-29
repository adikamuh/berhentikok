import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/base/string_extension.dart';
import 'package:berhentikok/model/achievement.dart';
import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/page/achievement/bloc/achievement_bloc.dart';
import 'package:berhentikok/page/achievement/widget/achievement_card_widget.dart';
import 'package:berhentikok/page/achievement/widget/achievement_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_spot/round_spot.dart';

class AchievementPage extends StatefulWidget {
  const AchievementPage({Key? key}) : super(key: key);

  static const routeName = 'achievement';

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  @override
  void initState() {
    super.initState();
    context.read<AchievementBloc>().add(LoadAchievement());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievement"),
        backgroundColor: ColorConst.darkGreen,
      ),
      body: BlocConsumer<AchievementBloc, Resource<AchievementState>>(
        listener: (context, state) {
          if (state is Error) {
            state.inferredErrorMessage!.showToast();
          }
        },
        builder: (context, state) {
          if (state is Success) {
            return Detector(
              areaID: 'achievement',
              child: ListView.builder(
                padding: SizeConst.pagePadding,
                itemCount: state.inferredData!.achievements.length,
                itemBuilder: (context, index) {
                  final Achievement achievement =
                      state.inferredData!.achievements[index];
                  return AchievementCardWidget(
                    onTap: () async {
                      context
                          .read<AchievementBloc>()
                          .add(ReadAchievment(achievement));
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return Detector(
                            areaID: 'achievement-dialog',
                            child: AchievementDetailDialog(
                              achievement: achievement,
                            ),
                          );
                        },
                      );
                    },
                    achievement: achievement,
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
