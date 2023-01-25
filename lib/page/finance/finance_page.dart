import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/base/int_extension.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/model/chart_type.dart';
import 'package:berhentikok/model/finance.dart';
import 'package:berhentikok/model/projection.dart';
import 'package:berhentikok/model/target_item.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/finance/bloc/add_item_bloc.dart';
import 'package:berhentikok/page/finance/cubit/finance_chart_cubit.dart';
import 'package:berhentikok/page/finance/widget/add_item_dialog.dart';
import 'package:berhentikok/page/finance/widget/money_saved_card_widget.dart';
import 'package:berhentikok/page/finance/widget/target_item_card_widget.dart';
import 'package:berhentikok/widget/chart_widget/chart_widget.dart';
import 'package:berhentikok/widget/section_widget/projection_child_widget.dart';
import 'package:berhentikok/widget/section_widget/section_statistic_detail_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:round_spot/round_spot.dart';

class FinancePage extends StatefulWidget {
  final Finance finance;
  final User user;
  final int moneySavedOnRelapse;
  const FinancePage({
    Key? key,
    required this.finance,
    required this.user,
    required this.moneySavedOnRelapse,
  }) : super(key: key);

  static const routeName = 'finance';

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  @override
  void initState() {
    context.read<FinanceChartCubit>().load();
    context.read<AddItemBloc>().add(LoadItems());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uang Tersimpan"),
        backgroundColor: ColorConst.darkGreen,
      ),
      body: Detector(
        areaID: 'finance',
        child: SingleChildScrollView(
          child: Padding(
            padding: SizeConst.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionStatisticDetailWidget(
                  showBorder: false,
                  child: MoneySavedCardWidget(
                    value: widget.moneySavedOnRelapse.toCurrencyFormatter(),
                  ),
                ),
                SectionStatisticDetailWidget(
                  title: 'Target Barang',
                  iconData: Icons.shopping_cart_rounded,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<AddItemBloc, AddItemState>(
                        builder: (context, state) {
                          if (state is ItemsLoaded) {
                            if (state.targetItems.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/icons/ic-shelves.png',
                                      width: 200.w,
                                    ),
                                    SizedBox(height: 12.h),
                                    Text(
                                      "Ayo tambah target barang impianmu!",
                                      style: FontConst.body(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Column(
                              children: state.targetItems
                                  .map(
                                    (item) => Padding(
                                      padding: EdgeInsets.only(bottom: 12.h),
                                      child: TargetItemCardWidget(
                                        targetItem: TargetItem(
                                          name: item.name,
                                          price: item.price,
                                        ),
                                        user: widget.user,
                                        moneySaved: widget.moneySavedOnRelapse,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyleConst.primary(),
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 30.w,
                                      vertical: 25.h,
                                    ),
                                    children: const [AddItemDialog()],
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Tambah Barang',
                                  style: FontConst.body(color: Colors.white),
                                ),
                                Icon(
                                  Icons.add_rounded,
                                  size: 18.w,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                BlocBuilder<FinanceChartCubit, List<FlSpot>>(
                  builder: (context, state) {
                    return SectionStatisticDetailWidget(
                      title: 'Penghematan uang',
                      iconData: Icons.equalizer_rounded,
                      child: SizedBox(
                        width: 350.w,
                        height: 230.h,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 14.h,
                            right: 32.w,
                            left: 8.w,
                          ),
                          child: ChartWidget(
                            chartType: ChartType.finance,
                            data: state,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SectionStatisticDetailWidget(
                  title: 'Estimasi penghematan',
                  iconData: Icons.payments_rounded,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ProjectionChildWidget(
                              projectionType: ProjectionType.day,
                              moneySavedOnRelapse: widget.moneySavedOnRelapse,
                              user: widget.user,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ProjectionChildWidget(
                              projectionType: ProjectionType.week,
                              moneySavedOnRelapse: widget.moneySavedOnRelapse,
                              user: widget.user,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.w),
                      Row(
                        children: [
                          Expanded(
                            child: ProjectionChildWidget(
                              projectionType: ProjectionType.month,
                              moneySavedOnRelapse: widget.moneySavedOnRelapse,
                              user: widget.user,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ProjectionChildWidget(
                              projectionType: ProjectionType.year,
                              moneySavedOnRelapse: widget.moneySavedOnRelapse,
                              user: widget.user,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
