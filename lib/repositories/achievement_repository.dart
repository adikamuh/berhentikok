import 'package:berhentikok/model/achievement.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AchievementRepository {
  final Box<Achievement> achievementsAchievedBox;

  AchievementRepository(this.achievementsAchievedBox);

  static List<Achievement> achievements = [
    Achievement(
      imageFile: 'assets/achievement/ic-blood-pressure.png',
      title: 'Tekanan darahmu sudah kembali normal!',
      description: '',
      dialogDescription:
          'Tekanan darahmu sudah berhasil kembali normal, sedikit demi sedikit kamu akan lebih sehat! Lanjutkan!',
      duration: const Duration(minutes: 20),
    ),
    Achievement(
      imageFile: 'assets/achievement/ic-free-smoking.png',
      title: 'Kamu sudah tidak merokok selama 1 hari',
      description: '',
      dialogDescription:
          'Wow! prosess yang sudah bagus buatmu. Lanjutkan terus hari demi hari ya!',
      duration: const Duration(days: 1),
    ),
    Achievement(
      imageFile: 'assets/achievement/ic-free-smoking.png',
      title: '7 Hari tanpa merokok!',
      description: '',
      dialogDescription:
          "Kamu sudah berhasil selama 7 hari terbebas dari rokok. Lanjutkan kebiasaan baik ini!",
      duration: const Duration(days: 7),
    ),
    Achievement(
      imageFile: 'assets/achievement/ic-free-smoking.png',
      title: 'test',
      description: '',
      dialogDescription: "test",
      duration: const Duration(days: 7),
    ),
    Achievement(
      imageFile: 'assets/achievement/ic-free-smoking.png',
      title: 'mock test',
      description: '',
      dialogDescription: "mock test",
      duration: const Duration(days: 1),
    ),
  ];

  List<Achievement> loadAchievements() {
    return achievements;
  }

  List<Achievement> loadAchievementsAchieved() {
    try {
      List<Achievement> achievements = loadAchievements();
      List<Achievement> achievementsOnAchieved = [];

      for (var i = 0; i < achievements.length; i++) {
        final Achievement achievement = achievements[i];
        final bool isAchieved = achievementsAchievedBox.containsKey(i);
        achievementsOnAchieved.add(achievement..isAchieved = isAchieved);
      }

      return achievementsOnAchieved;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  bool addAchievementAchieved(Achievement achievement, int index) {
    try {
      if (achievementsAchievedBox.containsKey(index)) {
        return false;
      } else {
        achievementsAchievedBox.add(achievement);
        return true;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteAll() async {
    achievementsAchievedBox.deleteAll(achievementsAchievedBox.keys);
    await achievementsAchievedBox.clear();
  }
}
