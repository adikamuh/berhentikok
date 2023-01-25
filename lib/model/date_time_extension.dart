import 'package:intl/intl.dart';

extension Ex on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String dateToString() {
    return DateFormat("d MMMM yyyy", "id_ID").format(this);
  }
}
