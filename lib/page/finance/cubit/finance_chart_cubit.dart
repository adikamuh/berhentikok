import 'package:berhentikok/helper/count_helper.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinanceChartCubit extends Cubit<List<FlSpot>> {
  final UserRepository userRepository;
  final SmokingDetailRepository smokingDetailRepository;
  FinanceChartCubit({
    required this.userRepository,
    required this.smokingDetailRepository,
  }) : super([]);

  void load() async {
    try {
      final List<SmokingDetail> smokingDetails =
          await smokingDetailRepository.loadAll();
      final User? user = userRepository.load();
      if (user != null) {
        Map<DateTime, int> daysFromStopSmoking = ChartHelper.financesToChart(
          user: user,
          smokingDetails: smokingDetails,
        );
        emit(_toFlSpots(user: user, daysStopSmokingMap: daysFromStopSmoking));
      } else {
        emit([]);
      }
    } catch (e) {
      emit([]);
    }
  }

  List<FlSpot> _toFlSpots({
    required User user,
    required Map<DateTime, int> daysStopSmokingMap,
  }) {
    List<FlSpot> flSpots = [];
    daysStopSmokingMap.forEach((date, total) {
      final int whatDay = date.difference(user.startDateStopSmoking).inDays + 1;
      flSpots.add(FlSpot(whatDay.toDouble(), total.toDouble()));
    });
    return flSpots;
  }
}
