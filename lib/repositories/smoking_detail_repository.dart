import 'package:berhentikok/model/smoking_detail.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SmokingDetailRepository {
  final Box<SmokingDetail> smokingDetailsBox;

  SmokingDetailRepository(this.smokingDetailsBox);

  Future<List<SmokingDetail>> loadAll() async {
    List<SmokingDetail> smokingDetails = smokingDetailsBox.values.toList();
    smokingDetails.sort(((a, b) => a.date.compareTo(b.date)));
    return smokingDetails;
  }

  Future<bool> add(SmokingDetail smokingDetail) async{
    try {
      await smokingDetailsBox.add(smokingDetail);
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
