import 'package:berhentikok/helper/count_helper.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:fl_chart/fl_chart.dart';

class ConsumptionChartCubit extends Cubit<List<FlSpot>> {
  final UserRepository userRepository;
  final SmokingDetailRepository smokingDetailRepository;
  ConsumptionChartCubit({
    required this.userRepository,
    required this.smokingDetailRepository,
  }) : super([]);

  void load() async {
    emit([]);
    try {
      final List<SmokingDetail> smokingDetails =
          await smokingDetailRepository.loadAll();
      final user = userRepository.load();
      if (user != null) {
        Map<DateTime, int> daysFromStopSmoking =
            ChartHelper.consumptionsToChart(
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
    List<FlSpot> _flSpots = [];
    daysStopSmokingMap.forEach((date, total) {
      final int whatDay = date.difference(user.startDateStopSmoking).inDays + 1;
      _flSpots.add(FlSpot(whatDay.toDouble(), (total.toDouble() * -1)));
    });
    return _flSpots;
  }
}
