import 'package:berhentikok/base/int_extension.dart';
import 'package:berhentikok/base/size_const.dart';
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

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
        child: Padding(
          padding: SizeConst.pagePadding,
          child: Column(
            children: [
              BlocBuilder<HealthBloc, HealthState>(
                builder: (context, state) {
                  if (state is HealthLoaded) {
                    return StatisticSectionWidget(
                      title: 'Kesehatan',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => HealthPage(
                                  healthProgresses: state.healthProgresses,
                                  smokingDetails: state.smokingDetails,
                                  user: state.user,
                                )),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          HealthCardWidget(
                            healthProgress: state.healthProgresses[0],
                            user: state.user,
                            smokingDetails: state.smokingDetails,
                          ),
                          SizedBox(height: 10.h),
                          HealthCardWidget(
                            healthProgress: state.healthProgresses[1],
                            smokingDetails: state.smokingDetails,
                            user: state.user,
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(height: 12.h),
              BlocBuilder<FinanceBloc, FinanceState>(
                builder: (context, financeState) {
                  if (financeState is FinanceLoaded) {
                    return StatisticSectionWidget(
                      title: 'Uang Tersimpan',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => FinancePage(
                                  finance: financeState.finance,
                                  user: financeState.user,
                                  moneySavedOnRelapse:
                                      financeState.moneySavedOnRelapse,
                                )),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          MoneySavedCardWidget(
                            value: financeState.moneySavedOnRelapse
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
                                        moneySaved:
                                            financeState.moneySavedOnRelapse,
                                        margin: EdgeInsets.zero,
                                      ),
                                    if (state.targetItems.length >= 2)
                                      TargetItemCardWidget(
                                        targetItem: state.targetItems[1],
                                        moneySaved:
                                            financeState.moneySavedOnRelapse,
                                        margin: EdgeInsets.zero,
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
              BlocBuilder<ConsumptionBloc, ConsumptionState>(
                builder: (context, state) {
                  if (state is ConsumptionLoaded) {
                    return StatisticSectionWidget(
                      title: 'Konsumsi Rokok',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => ConsumptionPage(
                                  user: state.user,
                                  smokingDetails: state.smokingDetails,
                                )),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          SmokingFreeTotalCardWidget(
                            total: state.smokingDetails
                                .totalFreeCigaretteOnRelapse(state.user),
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
    );
  }
}
