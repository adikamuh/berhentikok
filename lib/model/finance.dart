import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/target_item.dart';
import 'package:berhentikok/model/user.dart';
import 'package:equatable/equatable.dart';

class Finance extends Equatable {
  final int moneySaved;
  final List<TargetItem> targetItems;

  const Finance({
    required this.moneySaved,
    required this.targetItems,
  });

  @override
  List<Object?> get props => [moneySaved, targetItems];

  int countMoneySaved({
    required List<SmokingDetail> smokingDetails,
    required User user,
  }) {
    final int totalRelapse = smokingDetails.sumTotal();
    final int relapsePrice = totalRelapse * user.pricePerCigarette;
    final int moneySavedOnRelapse = moneySaved - relapsePrice;
    if (moneySavedOnRelapse < 0) {
      return 0;
    } else {
      return moneySavedOnRelapse;
    }
  }
}
