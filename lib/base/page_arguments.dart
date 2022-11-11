import 'package:berhentikok/model/finance.dart';
import 'package:berhentikok/model/health_progress.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/tips.dart';
import 'package:berhentikok/model/user.dart';

class HealthArguments {
  final List<HealthProgress> healthProgresses;
  final List<SmokingDetail> smokingDetails;
  final User user;

  HealthArguments({
    required this.healthProgresses,
    required this.smokingDetails,
    required this.user,
  });
}

class ConsumptionArguemnts {
  final User user;
  final List<SmokingDetail> smokingDetails;

  ConsumptionArguemnts({
    required this.user,
    required this.smokingDetails,
  });
}

class FinanceArguments {
  final Finance finance;
  final User user;
  final int moneySavedOnRelapse;

  FinanceArguments({
    required this.finance,
    required this.user,
    required this.moneySavedOnRelapse,
  });
}

class TipsDialogArguments {
  final List<Tips> tips;
  final int indexTips;
  final Function(int id) onPrev;
  final Function(int id) onNext;

  TipsDialogArguments({
    required this.tips,
    required this.indexTips,
    required this.onPrev,
    required this.onNext,
  });
}
