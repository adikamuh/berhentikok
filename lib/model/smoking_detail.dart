import 'package:berhentikok/model/date_time_extension.dart';
import 'package:berhentikok/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'smoking_detail.g.dart';

@HiveType(typeId: 1)
class SmokingDetail extends Equatable {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final String excuse;
  @HiveField(2)
  final int total;

  const SmokingDetail({
    required this.date,
    required this.excuse,
    required this.total,
  });

  static final DateFormat _format = DateFormat('d MMMM', 'id_ID');

  @override
  List<Object?> get props => [date, excuse, total];

  @override
  String toString() => "${_format.format(date)}: ${total.toString()} Rokok";

  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}

extension Ex on List<SmokingDetail> {
  int sumTotal() =>
      fold<int>(0, (previousValue, element) => element.total + previousValue);

  DateTime? lastDaySmoke() => isNotEmpty ? last.date : null;

  int totalFreeCigaretteOnRelapse(User user) {
    final total = user.totalFreeCigarette - sumTotal();
    if (total <= 0) {
      return 0;
    } else {
      return total;
    }
  }

  // consumption
  int totalSmokingOnDay(DateTime day) => fold(0, (previousValue, element) {
        if (element.date.isSameDay(day)) {
          return previousValue + element.total;
        }
        return previousValue;
      });

  int totalFreeCigaretteToThisDay({
    required User user,
    required DateTime day,
  }) {
    if (day.difference(user.startDateStopSmoking).inHours > 24) {
      return user.tobaccoConsumption -
          totalSmokingOnDay(day) +
          totalFreeCigaretteToThisDay(
            user: user,
            day: day.subtract(const Duration(days: 1)),
          );
    } else if (day.difference(user.startDateStopSmoking).inHours <= 24 &&
        day.difference(user.startDateStopSmoking).inHours > 0) {
      return -totalSmokingOnDay(day);
    }
    return 0;
  }

  // finance
  int totalMoneyCostOnDay(DateTime day, User user) =>
      fold(0, (previousValue, element) {
        if (element.date.isSameDay(day)) {
          return previousValue + (element.total * user.pricePerCigarette);
        }
        return previousValue;
      });

  int totalMoneySavedToThisDay({
    required User user,
    required DateTime day,
  }) {
    if (day.difference(user.startDateStopSmoking).inHours > 24) {
      return user.moneySavedEachDay -
          totalMoneyCostOnDay(day, user) +
          totalMoneySavedToThisDay(
            user: user,
            day: day.subtract(const Duration(days: 1)),
          );
    } else if (day.difference(user.startDateStopSmoking).inHours <= 24 &&
        day.difference(user.startDateStopSmoking).inHours > 0) {
      return -totalMoneyCostOnDay(day, user);
    }
    return 0;
  }
}
