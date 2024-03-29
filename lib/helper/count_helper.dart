import 'package:berhentikok/model/date_time_extension.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';

class ChartHelper {
  static Map<DateTime, int> consumptionsToChart({
    required User user,
    required List<SmokingDetail> smokingDetails,
  }) {
    Map<DateTime, int> daysFromStopSmoking = {};
    DateTime now = DateTime.now();
    DateTime day = user.startDateStopSmoking;
    while (!(day.isSameDay(now))) {
      int _sumOnDay = 0;
      if (day.isSameDay(user.startDateStopSmoking)) {
        final Duration _duration =
            DateTime(day.year, day.month, day.day, 24, 0, 0)
                .difference(user.startDateStopSmoking);
        _sumOnDay = (_duration.inHours ~/ user.hoursPerCigarette).toInt();
      } else {
        _sumOnDay = user.tobaccoConsumption;
      }

      if (daysFromStopSmoking.values.isNotEmpty) {
        final int _sumUntilYesterday = daysFromStopSmoking.values.last;
        _sumOnDay = _sumOnDay + _sumUntilYesterday;
      }

      daysFromStopSmoking[day] =
          _sumOnDay - smokingDetails.totalSmokingOnDay(day);
      day = day.add(const Duration(days: 1));
    }
    daysFromStopSmoking[day] = smokingDetails.totalFreeCigaretteOnRelapse(user);

    return daysFromStopSmoking.map(
      (date, total) => MapEntry(date, total < 0 ? 0 : total),
    );
  }

  static Map<DateTime, int> financesToChart({
    required User user,
    required List<SmokingDetail> smokingDetails,
  }) {
    return consumptionsToChart(
      user: user,
      smokingDetails: smokingDetails,
    ).map((day, totalSmokes) => MapEntry(
          day,
          totalSmokes * user.pricePerCigarette,
        ));
  }
}
