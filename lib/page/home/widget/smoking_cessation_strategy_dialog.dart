import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum StrategyWeeks { week1, week5, week9 }

class SmokingCessationStrategyDialog extends StatelessWidget {
  const SmokingCessationStrategyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Strategimu untuk Berhenti Merokok!",
          style: FontConst.header2(),
        ),
        SizedBox(height: 24.h),
        // WHEN
        ..._buildStrategy(
          isCompleted: true,
          isOnprogress: false,
          weeks: StrategyWeeks.week1,
        ),
        ..._buildStrategy(
          isCompleted: false,
          isOnprogress: true,
          weeks: StrategyWeeks.week5,
        ),
        ..._buildStrategy(
          isCompleted: false,
          isOnprogress: false,
          weeks: StrategyWeeks.week9,
          showLine: false,
        ),
      ],
    );
  }

  List<Widget> _buildStrategy({
    required bool isCompleted,
    required bool isOnprogress,
    required StrategyWeeks weeks,
    bool showLine = true,
  }) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 25.w,
            height: 25.w,
            decoration: BoxDecoration(
              color: isCompleted || isOnprogress
                  ? ColorConst.darkGreen
                  : ColorConst.lightGreen,
              shape: BoxShape.circle,
              border: isCompleted || !isOnprogress
                  ? null
                  : Border.all(
                      width: 20.w,
                      color: ColorConst.lightGreen,
                    ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weeks == StrategyWeeks.week1
                      ? "Minggu ke-1 sampai ke-4"
                      : weeks == StrategyWeeks.week5
                          ? "Minggu ke-5 sampai ke-8"
                          : weeks == StrategyWeeks.week9
                              ? "Minggu ke-9 sampai ke-12"
                              : "",
                  style: FontConst.body(fontWeight: FontWeight.w600),
                ),
                Text(
                  weeks == StrategyWeeks.week1
                      ? "25 Januari - 29 Januari 2023"
                      : weeks == StrategyWeeks.week5
                          ? "30 Januari - 9 Februari 2023"
                          : weeks == StrategyWeeks.week9
                              ? "10 Februari - 15 Februari 2023"
                              : "",
                  style: FontConst.small(color: ColorConst.darkGreen),
                ),
              ],
            ),
          ),
        ],
      ),
      // WHAT TO DO
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLine) ...[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              width: 1.w,
              height: 100.h,
              decoration: const BoxDecoration(
                color: ColorConst.greyColor1,
              ),
            ),
            SizedBox(width: 12.w),
          ],
          if (!showLine) SizedBox(width: 37.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 16.h),
                Text(
                  weeks == StrategyWeeks.week1
                      ? "Kurangi konsumsi rokokmu per hari sampai 50%, batas konsumsi rokokmu:"
                      : weeks == StrategyWeeks.week5
                          ? "Kurangi konsumsi rokokmu per hari sampai 75%, batas konsumsi rokokmu:"
                          : weeks == StrategyWeeks.week9
                              ? "Kurangi konsumsi rokokmu per hari sampai 100%, batas konsumsi rokokmu:"
                              : "",
                  style: FontConst.small(),
                ),
                Text(
                  weeks == StrategyWeeks.week1
                      ? "8 Rokok / hari"
                      : weeks == StrategyWeeks.week5
                          ? "4 Rokok / hari"
                          : weeks == StrategyWeeks.week9
                              ? "0 Rokok / hari"
                              : "",
                  style: FontConst.header3(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }
}
