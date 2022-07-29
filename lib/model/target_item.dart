import 'package:berhentikok/base/int_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'target_item.g.dart';

@HiveType(typeId: 2)
class TargetItem extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int price;

  const TargetItem({
    required this.name,
    required this.price,
  });

  @override
  List<Object?> get props => [name, price];

  String toStringProgress(int totalMoneySaved) {
    if (totalMoneySaved >= price) {
      return "${price.toCurrencyFormatter()} / ${price.toCurrencyFormatter()}";
    } else {
      return "${totalMoneySaved.toCurrencyFormatter()} / ${price.toCurrencyFormatter()}";
    }
  }
}
