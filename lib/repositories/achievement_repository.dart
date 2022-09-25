import 'package:berhentikok/model/achievement.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AchievementRepository {
  final Box<Achievement> achievementsReadBox;

  AchievementRepository(this.achievementsReadBox);

  static List<Achievement> achievements = [
    const Achievement(
      id: 0,
      imageFile: 'assets/achievement/ic-blood-pressure.png',
      title: 'Tekanan darahmu sudah kembali normal!',
      description: '',
      dialogDescription:
          'Tekanan darahmu sudah berhasil kembali normal, sedikit demi sedikit kamu akan lebih sehat! Lanjutkan!',
      duration: Duration(minutes: 20),
    ),
    const Achievement(
      id: 1,
      imageFile: 'assets/achievement/ic-free-smoking.png',
      title: 'Kamu sudah tidak merokok selama 1 hari',
      description: '',
      dialogDescription:
          'Wow! prosess yang sudah bagus buatmu. Lanjutkan terus hari demi hari ya!',
      duration: Duration(days: 1),
    ),
    // Achievement(
    //   imageFile: 'assets/achievement/ic-free-smoking.png',
    //   title: '7 Hari tanpa merokok!',
    //   description: '',
    //   dialogDescription:
    //       "Kamu sudah berhasil selama 7 hari terbebas dari rokok. Lanjutkan kebiasaan baik ini!",
    //   duration: const Duration(days: 7),
    // ),
    // Achievement(
    //   imageFile: 'assets/achievement/ic-free-smoking.png',
    //   title: 'test',
    //   description: '',
    //   dialogDescription: "test",
    //   duration: const Duration(days: 7),
    // ),
    // Achievement(
    //   imageFile: 'assets/achievement/ic-free-smoking.png',
    //   title: 'mock test',
    //   description: '',
    //   dialogDescription: "mock test",
    //   duration: const Duration(days: 1),
    // ),
  ];

  List<Achievement> loadAchievements() {
    return achievements;
  }

  List<Achievement> loadAchievementsRead() {
    try {
      return achievementsReadBox.values.toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  bool addAchievementRead(Achievement achievement) {
    try {
      if (achievementsReadBox.values.firstWhereOrNull(
            (achievementRead) => achievementRead.id == achievement.id,
          ) !=
          null) {
        return false;
      } else {
        achievementsReadBox.add(achievement);
        return true;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteAll() async {
    achievementsReadBox.deleteAll(achievementsReadBox.keys);
    await achievementsReadBox.clear();
  }
}
