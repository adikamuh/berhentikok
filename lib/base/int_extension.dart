import 'package:intl/intl.dart';

extension Ex on int {
  String toCurrencyFormatter() => NumberFormat.currency(
        locale: 'ID',
        symbol: "Rp ",
        decimalDigits: 0,
      ).format(this);

  String toCompactCurrencyFormatter() => NumberFormat.compactCurrency(
        locale: 'ID',
        symbol: "Rp ",
        decimalDigits: 0,
      ).format(this);

  String toCompactThousandFormatter() =>
      NumberFormat.compact(locale: 'id_ID').format(this);

  String toThousandFormatter() =>
      NumberFormat.decimalPattern('id_ID').format(this);
}
