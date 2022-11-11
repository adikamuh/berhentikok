import 'package:berhentikok/model/achievement.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AchievementRepository {
  final Box<Achievement> achievementsReadBox;

  AchievementRepository(this.achievementsReadBox);

  static List<Achievement> achievements = [
    const Achievement(
      id: 1,
      imageFile: 'assets/achievement/ic-one-day-smoking.png',
      title: 'Kamu sudah tidak merokok selama sehari',
      description: '',
      dialogDescription:
          'Wow! prosess yang sudah bagus buatmu. Lanjutkan terus hari demi hari ya!',
      duration: Duration(days: 1),
    ),
    const Achievement(
      id: 2,
      imageFile: 'assets/achievement/ic-one-week-smoking.png',
      title: 'Seminggu sudah kamu tidak merokok!',
      description: '',
      dialogDescription:
          'Selamat kamu sudah bebas rokok selama seminggu. Lanjutkan terus di minggu berikutnya!',
      duration: Duration(days: 7),
    ),
    const Achievement(
      id: 3,
      imageFile: 'assets/achievement/ic-one-month-smoking.png',
      title: 'Selamat kamu sudah tidak merokok selama sebulan!',
      description: '',
      dialogDescription:
          'Semoga di bulan berikutnya dan seterusnya kamu sudah tidak merokok lagi ya!',
      duration: Duration(days: 30),
    ),
    const Achievement(
      id: 4,
      imageFile: 'assets/achievement/ic-50-money.png',
      title: '50 ribu pertamamu!',
      description: '',
      dialogDescription:
          'Yayy selamat! Kamu sudah mendapatkan 50 ribu pertamamu',
      moneyCount: 50000,
    ),
    const Achievement(
      id: 5,
      imageFile: 'assets/achievement/ic-200-money.png',
      title: 'Yay, kamu berhasil menghemat hingga 200 ribu!',
      description: '',
      dialogDescription:
          'Wahh 200 ribu sudah bisa kamu hemat nih. Untuk beli apa ya?',
      moneyCount: 200000,
    ),
    const Achievement(
      id: 6,
      imageFile: 'assets/achievement/ic-500-money.png',
      title: 'Tidak terasa ya, kamu sudah mendapatkan 500 ribu pertamamu!',
      description: '',
      dialogDescription: 'Bisa buat beli mi ayam nih se-gerobak penuh!',
      moneyCount: 500000,
    ),
    const Achievement(
      id: 7,
      imageFile: 'assets/achievement/ic-smoke-trash.png',
      title: 'Kamu sudah ikut mengurangi polusi dari sampah puntung rokok!',
      description: '',
      dialogDescription:
          'Tahukah kamu kalau puntung rokok menyumbang lebih dari 766 juta kilogram sampah beracun setiap tahun. Dan kamu sudah berperan untuk menguranginya!',
      smokeCount: 20,
    ),
    const Achievement(
      id: 8,
      imageFile: 'assets/achievement/ic-50-smoke.png',
      title: 'Wah, 50 batang rokok sudah berhasil kamu kurangi',
      description: '',
      dialogDescription: 'Selamat kamu sudah memulai kebiasaan baik barumu',
      smokeCount: 50,
    ),
    const Achievement(
      id: 9,
      imageFile: 'assets/achievement/ic-100-smoke.png',
      title: 'Hebat sekali! Kamu sudah berhasil tidak merokok hingga 100 kali',
      description: '',
      dialogDescription:
          'Selain mengurangi sampah rokok, kamu juga berperan loh untuk mengurangi polusi udara akibat asap rokok!',
      smokeCount: 100,
    ),
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
