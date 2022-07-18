import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class SmokingDetail extends Equatable {
  final DateTime date;
  final String excuse;
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

  String sumTotal(List<SmokingDetail> smokingDetails) {
    return smokingDetails
        .fold<int>(0, (previousValue, element) => element.total + previousValue)
        .toString();
  }

  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
