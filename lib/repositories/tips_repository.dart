import 'package:berhentikok/model/tips.dart';
import 'package:hive/hive.dart';

class TipsRepository {
  final Box<int> tipsBox;
  TipsRepository(this.tipsBox);

  static List<Tips> tips = [
    const Tips(
      id: 0,
      description:
          'Simpan atau buang semua barang-barang yang memiliki kandungan nikotin di ruanganmu',
    ),
    const Tips(
      id: 1,
      description:
          'Berolahraga secara teratur juga bisa membantu proses menghilangkan kebiasaan merokokmu loh!',
    ),
    const Tips(
      id: 2,
      description:
          'Minta-lah dukugan keluarga, sahabat, dan lingkungan sekitarmu',
    ),
    const Tips(
      id: 3,
      description:
          'Selain baik untuk kesehatan, berhenti merokok juga bisa membantu menghilangkan stres, kecemasan, dan depresi',
    ),
    const Tips(
      id: 4,
      description:
          'Kalau kamu kesulitan untuk berhenti secara total, cobalah untuk mengurangi konsumsi rokokmu per-harinya',
    ),
    // const Tips(
    //   id: 5,
    //   description:
    //       'Jika kamu adalah orang yang cukup susah untuk tidak merokok, cobalah gunakan alat pengganti nikotin seperti niccotine gum',
    // ),
    const Tips(
      id: 6,
      description:
          'Jika kamu punya keinginan untuk merokok yang tinggi, ingatlah apa yang membuat kamu ingin berhenti merokok',
    ),
    const Tips(
      id: 7,
      description:
          'Tidak apa-apa jika kamu pernah gagal, tapi ingat yang terpenting adalah berprogres di hari berikutnya!',
    ),
  ];

  List<Tips> load() => tips;

  int loadLastState() {
    if (tipsBox.isEmpty) return 0;
    try {
      return tipsBox.get(0)!;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> putLastState(int id) async {
    try {
      if (tipsBox.isEmpty) {
        await tipsBox.add(id);
      } else {
        await tipsBox.put(0, id);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
