import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class TargetItem extends Equatable {
  final String name;
  final int price;

  const TargetItem({
    required this.name,
    required this.price,
  });

  @override
  List<Object?> get props => [name, price];

  String toCurrencyFormatter() =>
      NumberFormat.currency(locale: 'ID', symbol: "Rp ", decimalDigits: 0)
          .format(price);
}
