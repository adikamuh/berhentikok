import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/base/int_extension.dart';
import 'package:berhentikok/model/projection.dart';
import 'package:berhentikok/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectionChildWidget extends StatelessWidget {
  final ProjectionType projectionType;
  final int? moneySavedOnRelapse;
  final int? totalFreeCigaretteOnRelapse;
  final User user;
  const ProjectionChildWidget({
    super.key,
    required this.projectionType,
    this.moneySavedOnRelapse,
    this.totalFreeCigaretteOnRelapse,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    // List<Widget> widgets = [];
    if (moneySavedOnRelapse != null) {
      // widgets = _buildFinanceProjection();
    } else if (totalFreeCigaretteOnRelapse != null) {
      // widgets = _buildConsumptionProjection();
    }
    return AspectRatio(
      aspectRatio: 20 / 9,
      child: Container(
        decoration: BoxDecoration(
          color: ColorConst.lightGreen,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _buildTimeCaption(),
              style: FontConst.small(
                color: ColorConst.darkGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              moneySavedOnRelapse != null
                  ? _buildFinanceProjection()
                  : _buildConsumptionProjection(),
              style: FontConst.header2(fontSize: 20.sp),
            ),
          ],
        ),
      ),
    );
  }

  String _buildTimeCaption() {
    if (projectionType == ProjectionType.day) {
      return "sampai besok";
    } else if (projectionType == ProjectionType.week) {
      return "seminggu kedepan";
    } else if (projectionType == ProjectionType.month) {
      return "sebulan kedepan";
    } else if (projectionType == ProjectionType.year) {
      return "setahun kedepan";
    }
    return "";
  }

  String _buildFinanceProjection() {
    if (projectionType == ProjectionType.day) {
      final total = moneySavedOnRelapse! + user.moneySavedEachDay;
      return "+ ${total.toCompactCurrencyFormatter()}";
    } else if (projectionType == ProjectionType.week) {
      final total = moneySavedOnRelapse! + (user.moneySavedEachDay * 7);
      return "+ ${total.toCompactCurrencyFormatter()}";
    } else if (projectionType == ProjectionType.month) {
      final total = moneySavedOnRelapse! + (user.moneySavedEachDay * 30);
      return "+ ${total.toCompactCurrencyFormatter()}";
    } else if (projectionType == ProjectionType.year) {
      final total = moneySavedOnRelapse! + (user.moneySavedEachDay * 365);
      return "+ ${total.toCompactCurrencyFormatter()}";
    }
    return "";
  }

  String _buildConsumptionProjection() {
    if (projectionType == ProjectionType.day) {
      final total = totalFreeCigaretteOnRelapse! + user.tobaccoConsumption;
      return "- ${total.toCompactThousandFormatter()} rokok";
    } else if (projectionType == ProjectionType.week) {
      final total =
          totalFreeCigaretteOnRelapse! + (user.tobaccoConsumption * 7);
      return "- ${total.toCompactThousandFormatter()} rokok";
    } else if (projectionType == ProjectionType.month) {
      final total =
          totalFreeCigaretteOnRelapse! + (user.tobaccoConsumption * 30);
      return "- ${total.toCompactThousandFormatter()} rokok";
    } else if (projectionType == ProjectionType.year) {
      final total =
          totalFreeCigaretteOnRelapse! + (user.tobaccoConsumption * 365);
      return "- ${total.toCompactThousandFormatter()} rokok";
    }
    return "";
  }
}
