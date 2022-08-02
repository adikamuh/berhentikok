import 'package:berhentikok/model/health_progress.dart';

class HealthProgressRepository {
  HealthProgressRepository();

  static List<HealthProgress> healthProgresses = [
    const HealthProgress(
      imageFile: 'assets/health/ic-blood-pressure.png',
      caption: 'Tekanan darah kembali normal',
      startDuration: Duration(minutes: 20),
      endDuration: Duration(minutes: 20),
    ),
    const HealthProgress(
      imageFile: 'assets/health/ic-co-free.png',
      caption: 'Kadar CO dalam tubuhmu turun menjadi normal',
      startDuration: Duration(hours: 12),
      endDuration: Duration(hours: 12),
    ),
    const HealthProgress(
      imageFile: 'assets/health/ic-nicotine-free.png',
      caption: 'Sudah tidak ada lagi Nikotin di tubuhmu',
      startDuration: Duration(hours: 24),
      endDuration: Duration(hours: 24),
    ),
    const HealthProgress(
      imageFile: 'assets/health/ic-lungs.png',
      caption: 'Fungsi kerja paru-parumu sudah mulai meningkat loh',
      startDuration: Duration(days: 28),
      endDuration: Duration(days: 84),
    ),
    const HealthProgress(
      imageFile: 'assets/health/ic-cough.png',
      caption: 'Rasa batuk dan sesak nafasmu mulai berkurang',
      startDuration: Duration(days: 30),
      endDuration: Duration(days: 365),
    ),
    const HealthProgress(
      imageFile: 'assets/health/ic-heart-attack.png',
      caption: 'Resiko kamu terkena serangan jantung menurun secara tajam',
      startDuration: Duration(days: 365),
      endDuration: Duration(days: 730),
    ),
    const HealthProgress(
      imageFile: 'assets/health/ic-coronary.png',
      caption:
          'Kemungkinan kamu terkena jantung koroner berkurang lebih dari 50%',
      startDuration: Duration(days: 1095),
      endDuration: Duration(days: 2190),
    ),
    const HealthProgress(
      imageFile: 'assets/health/ic-cancer.png',
      caption:
          'Kanker mulut, tenggorokan, dan kotak suara akan jauh-jauh dari kamu',
      startDuration: Duration(days: 1825),
      endDuration: Duration(days: 3650),
    ),
    const HealthProgress(
      imageFile: 'assets/health/ic-lungs-free.png',
      caption:
          'Kemungkinan kamu terkena kanker paru-paru berkurang lebih dari 50%',
      startDuration: Duration(days: 3650),
      endDuration: Duration(days: 3650),
    ),
    const HealthProgress(
      imageFile: 'assets/health/ic-coronary-free.png',
      caption: 'Risiko kanker kandung kemih, kerongkongan, dan ginjal menurun',
      startDuration: Duration(days: 3650),
      endDuration: Duration(days: 3650),
    ),
    const HealthProgress(
      imageFile: 'assets/health/ic-coronary-free.png',
      caption:
          'Risiko penyakit jantung koroner turun seperti seseorang yang tidak merokok',
      startDuration: Duration(days: 5475),
      endDuration: Duration(days: 5475),
    ),
    const HealthProgress(
      imageFile: 'assets/health/ic-cancer-free.png',
      caption:
          'Risiko kanker mulut, tenggorokan, dan kotak suara turun seperti seseorang yang tidak merokok',
      startDuration: Duration(days: 7300),
      endDuration: Duration(days: 7300),
    ),
    const HealthProgress(
      imageFile: 'assets/health/ic-pancreas.png',
      caption:
          'Risiko kanker pankreas turun seperti seseorang yang tidak merokok',
      startDuration: Duration(days: 7300),
      endDuration: Duration(days: 7300),
    ),
    const HealthProgress(
      imageFile: 'assets/health/ic-cervics-free.png',
      caption:
          'Kemungkinan kamu punya penyakit tambahan seperti kanker serviks turun lebih dari 50%',
      startDuration: Duration(days: 7300),
      endDuration: Duration(days: 7300),
    ),
  ];

  List<HealthProgress> load() {
    return healthProgresses;
  }
}
