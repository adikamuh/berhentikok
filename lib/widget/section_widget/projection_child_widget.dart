import 'package:berhentikok/base/int_extension.dart';
import 'package:berhentikok/model/projection.dart';
import 'package:berhentikok/model/user.dart';
import 'package:flutter/material.dart';

class ProjectionChildWidget extends StatelessWidget {
  final ProjectionType projectionType;
  final int? moneySavedOnRelapse;
  final int? totalFreeCigaretteOnRelapse;
  final User user;
  const ProjectionChildWidget({
    Key? key,
    required this.projectionType,
    this.moneySavedOnRelapse,
    this.totalFreeCigaretteOnRelapse,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if (moneySavedOnRelapse != null) {
      widgets = _buildFinanceProjection();
    } else if (totalFreeCigaretteOnRelapse != null) {
      widgets = _buildConsumptionProjection();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets,
    );
  }

  List<Widget> _buildFinanceProjection() {
    if (projectionType == ProjectionType.day) {
      final total = moneySavedOnRelapse! + user.moneySavedEachDay;
      return [
        const Text('Dalam sehari'),
        Text(total.toCurrencyFormatter()),
      ];
    } else if (projectionType == ProjectionType.week) {
      final total = moneySavedOnRelapse! + (user.moneySavedEachDay * 7);
      return [
        const Text('Dalam seminggu'),
        Text(total.toCurrencyFormatter()),
      ];
    } else if (projectionType == ProjectionType.month) {
      final total = moneySavedOnRelapse! + (user.moneySavedEachDay * 30);
      return [
        const Text('Dalam sebulan'),
        Text(total.toCurrencyFormatter()),
      ];
    } else if (projectionType == ProjectionType.year) {
      final total = moneySavedOnRelapse! + (user.moneySavedEachDay * 365);
      return [
        const Text('Dalam setahun'),
        Text(total.toCurrencyFormatter()),
      ];
    }
    return [];
  }

  List<Widget> _buildConsumptionProjection() {
    if (projectionType == ProjectionType.day) {
      final total = totalFreeCigaretteOnRelapse! + user.tobaccoConsumption;
      return [
        const Text('Dalam sehari'),
        Text("${total.toThousandFormatter()} batang"),
      ];
    } else if (projectionType == ProjectionType.week) {
      final total =
          totalFreeCigaretteOnRelapse! + (user.tobaccoConsumption * 7);
      return [
        const Text('Dalam seminggu'),
        Text("${total.toThousandFormatter()} batang"),
      ];
    } else if (projectionType == ProjectionType.month) {
      final total =
          totalFreeCigaretteOnRelapse! + (user.tobaccoConsumption * 30);
      return [
        const Text('Dalam sebulan'),
        Text("${total.toThousandFormatter()} batang"),
      ];
    } else if (projectionType == ProjectionType.year) {
      final total =
          totalFreeCigaretteOnRelapse! + (user.tobaccoConsumption * 365);
      return [
        const Text('Dalam setahun'),
        Text("${total.toThousandFormatter()} batang"),
      ];
    }
    return [];
  }
}
