import 'package:berhentikok/base/int_extension.dart';
import 'package:berhentikok/base/page_arguments.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/model/health_progress.dart';
import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/page/consumption/bloc/consumption_bloc.dart';
import 'package:berhentikok/page/consumption/consumption_page.dart';
import 'package:berhentikok/page/consumption/widget/smoking_free_total_card_widget.dart';
import 'package:berhentikok/page/finance/bloc/add_item_bloc.dart';
import 'package:berhentikok/page/finance/bloc/finance_bloc.dart';
import 'package:berhentikok/page/finance/finance_page.dart';
import 'package:berhentikok/page/finance/widget/money_saved_card_widget.dart';
import 'package:berhentikok/page/finance/widget/target_item_card_widget.dart';
import 'package:berhentikok/page/health/bloc/health_bloc.dart';
import 'package:berhentikok/page/health/health_page.dart';
import 'package:berhentikok/page/health/widget/health_card_widget.dart';
import 'package:berhentikok/page/statistic/widget/statistic_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:round_spot/round_spot.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

  static const routeName = 'statistic';

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  void initState() {
    context.read<HealthBloc>().add(LoadHealth());
    context.read<FinanceBloc>().add(LoadFinance());
    context.read<AddItemBloc>().add(LoadItems());
    context.read<ConsumptionBloc>().add(LoadConsumption());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Detector(
      areaID: 'statistic',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
          child: Padding(
            padding: SizeConst.pagePadding,
            child: Column(
              children: [
                BlocBuilder<HealthBloc, Resource<HealthState>>(
                  builder: (context, state) {
                    if (state is Success) {
                      final Duration freeSmokingDuration = state
                          .inferredData!.smokingDetails
                          .freeSmokingDuration(state.inferredData!.user);
                      return StatisticSectionWidget(
                        title: 'Kesehatan',
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            HealthPage.routeName,
                            arguments: HealthArguments(
                              healthProgresses:
                                  state.inferredData!.healthProgresses,
                              smokingDetails:
                                  state.inferredData!.smokingDetails,
                              user: state.inferredData!.user,
                            ),
                          );
                        },
                        child: Column(
                          children: state.inferredData!.healthProgresses
                              .firstTwoOnProgress(
                                smokingDetails:
                                    state.inferredData!.smokingDetails,
                                user: state.inferredData!.user,
                              )
                              .map<Widget>(
                                (healthProgress) => Column(
                                  children: [
                                    HealthCardWidget(
                                      healthProgress: healthProgress,
                                      user: state.inferredData!.user,
                                      freeSmokingDuration: freeSmokingDuration,
                                      smokingDetails:
                                          state.inferredData!.smokingDetails,
                                    ),
                                    SizedBox(height: 10.h),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(height: 12.h),
                BlocBuilder<FinanceBloc, Resource<FinanceState>>(
                  builder: (context, financeState) {
                    if (financeState is Success) {
                      return StatisticSectionWidget(
                        title: 'Uang Tersimpan',
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            FinancePage.routeName,
                            arguments: FinanceArguments(
                              finance: financeState.inferredData!.finance,
                              user: financeState.inferredData!.user,
                              moneySavedOnRelapse: financeState
                                  .inferredData!.moneySavedOnRelapse,
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            MoneySavedCardWidget(
                              value: financeState
                                  .inferredData!.moneySavedOnRelapse
                                  .toCurrencyFormatter(),
                            ),
                            SizedBox(height: 10.h),
                            BlocBuilder<AddItemBloc, AddItemState>(
                              builder: (context, state) {
                                if (state is ItemsLoaded &&
                                    state.targetItems.isNotEmpty) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (state.targetItems.isNotEmpty)
                                        TargetItemCardWidget(
                                          targetItem: state.targetItems.first,
                                          moneySaved: financeState.inferredData!
                                              .moneySavedOnRelapse,
                                          margin: EdgeInsets.zero,
                                          user: financeState.inferredData!.user,
                                        ),
                                      if (state.targetItems.length >= 2)
                                        TargetItemCardWidget(
                                          targetItem: state.targetItems[1],
                                          moneySaved: financeState.inferredData!
                                              .moneySavedOnRelapse,
                                          margin: EdgeInsets.zero,
                                          user: financeState.inferredData!.user,
                                        ),
                                    ],
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(height: 12.h),
                BlocBuilder<ConsumptionBloc, Resource<ConsumptionState>>(
                  builder: (context, state) {
                    if (state is Success) {
                      return StatisticSectionWidget(
                        title: 'Konsumsi Rokok',
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ConsumptionPage.routeName,
                            arguments: ConsumptionArguemnts(
                              user: state.inferredData!.user,
                              smokingDetails:
                                  state.inferredData!.smokingDetails,
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            SmokingFreeTotalCardWidget(
                              total: state.inferredData!.smokingDetails
                                  .totalFreeCigaretteOnRelapse(
                                state.inferredData!.user,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
