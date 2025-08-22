import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/model/date_time_extension.dart';
import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/home/bloc/home_page_bloc.dart';
import 'package:berhentikok/page/home/cubit/smoking_strategy_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmokingCessationStrategyDialog extends StatelessWidget {
  const SmokingCessationStrategyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmokingStrategyCubit, Resource<SmokingStrategyState>>(
      builder: (context, state) {
        if (state is! Success) return const SizedBox();
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
              isCompleted:
                  state.inferredData!.strategyWeeks != StrategyWeeks.week1,
              isOnprogress:
                  state.inferredData!.strategyWeeks == StrategyWeeks.week1,
              weeks: StrategyWeeks.week1,
              user: state.inferredData!.user,
            ),
            ..._buildStrategy(
              isCompleted:
                  state.inferredData!.strategyWeeks != StrategyWeeks.week1 &&
                  state.inferredData!.strategyWeeks != StrategyWeeks.week5,
              isOnprogress:
                  state.inferredData!.strategyWeeks == StrategyWeeks.week5,
              weeks: StrategyWeeks.week5,
              user: state.inferredData!.user,
            ),
            ..._buildStrategy(
              isCompleted:
                  state.inferredData!.strategyWeeks != StrategyWeeks.week1 &&
                  state.inferredData!.strategyWeeks != StrategyWeeks.week5 &&
                  state.inferredData!.strategyWeeks != StrategyWeeks.week9,
              isOnprogress:
                  state.inferredData!.strategyWeeks == StrategyWeeks.week9,
              weeks: StrategyWeeks.week9,
              user: state.inferredData!.user,
              showLine: false,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyleConst.primary(),
                  onPressed: () {
                    context.read<HomePageBloc>().add(UserDoneFirstTime());
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Oke!',
                    style: FontConst.body(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildStrategy({
    required bool isCompleted,
    required bool isOnprogress,
    required StrategyWeeks weeks,
    required User user,
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
              color:
                  isCompleted || isOnprogress
                      ? ColorConst.darkGreen
                      : ColorConst.lightGreen,
              shape: BoxShape.circle,
              border:
                  isCompleted || !isOnprogress
                      ? null
                      : Border.all(width: 20.w, color: ColorConst.lightGreen),
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
                      ? "${user.startDateStopSmoking.dateToString()} - ${user.startDateStopSmoking.add(const Duration(days: 28)).dateToString()}"
                      : weeks == StrategyWeeks.week5
                      ? "${user.startDateStopSmoking.add(const Duration(days: 29)).dateToString()} - ${user.startDateStopSmoking.add(const Duration(days: 56)).dateToString()}"
                      : weeks == StrategyWeeks.week9
                      ? "${user.startDateStopSmoking.add(const Duration(days: 57)).dateToString()} - ${user.startDateStopSmoking.add(const Duration(days: 84)).dateToString()}"
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
              decoration: const BoxDecoration(color: ColorConst.greyColor1),
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
                      ? "${user.tobaccoConsumption ~/ 2} Rokok / hari"
                      : weeks == StrategyWeeks.week5
                      ? "${user.tobaccoConsumption ~/ 4} Rokok / hari"
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
