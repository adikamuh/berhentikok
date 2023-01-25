import 'package:berhentikok/model/smoking_detail.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SmokingDetailRepository {
  final Box<SmokingDetail> smokingDetailsBox;

  SmokingDetailRepository(this.smokingDetailsBox);

  Future<List<SmokingDetail>> loadAll() async {
    List<SmokingDetail> smokingDetails = smokingDetailsBox.values.toList();
    smokingDetails.addAll(mockSmokings);
    smokingDetails.sort(((a, b) => a.date.compareTo(b.date)));
    return smokingDetails;
  }

  Future<bool> add(SmokingDetail smokingDetail) async {
    try {
      await smokingDetailsBox.add(smokingDetail);
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<SmokingDetail> mockSmokings = [
    SmokingDetail(
      date: DateTime.now().subtract(const Duration(days: 14)),
      excuse: "Lingkungan sekeitar merokok semua",
      total: 4,
    ),
    SmokingDetail(
      date: DateTime.now().subtract(const Duration(days: 10)),
      excuse: "Lagi pusing",
      total: 6,
    ),
    SmokingDetail(
      date: DateTime.now().subtract(const Duration(days: 1)),
      excuse: "Rasa ingin merokok tinggi",
      total: 2,
    ),
  ];
}
