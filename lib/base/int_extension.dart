import 'package:intl/intl.dart';

extension Ex on int {
  String toCurrencyFormatter() =>
      NumberFormat.currency(locale: 'ID', symbol: "Rp ", decimalDigits: 0)
          .format(this);

  String toThousandFormatter() => NumberFormat.decimalPattern('id_ID').format(this);
}
