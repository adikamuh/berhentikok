import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/model/chart_type.dart';
import 'package:berhentikok/model/projection.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/consumption/bloc/smoking_detail_bloc.dart';
import 'package:berhentikok/page/consumption/cubit/consumption_chart_cubit.dart';
import 'package:berhentikok/page/consumption/widget/add_smoking_detail_dialog.dart';
import 'package:berhentikok/page/consumption/widget/calendar_table_widget.dart';
import 'package:berhentikok/page/consumption/widget/smoking_free_total_card_widget.dart';
import 'package:berhentikok/widget/chart_widget/chart_widget.dart';
import 'package:berhentikok/widget/section_widget/projection_child_widget.dart';
import 'package:berhentikok/widget/section_widget/section_statistic_detail_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsumptionPage extends StatefulWidget {
  final User user;
  final List<SmokingDetail> smokingDetails;
  const ConsumptionPage({
    Key? key,
    required this.user,
    required this.smokingDetails,
  }) : super(key: key);

  @override
  State<ConsumptionPage> createState() => _ConsumptionPageState();
}

class _ConsumptionPageState extends State<ConsumptionPage> {
  late int _totalFreeCigaretteOnRelapse;

  @override
  void initState() {
    super.initState();
    context.read<SmokingDetailBloc>().add(LoadSmokingDetails());
    context.read<ConsumptionChartCubit>().load();
    _totalFreeCigaretteOnRelapse =
        widget.smokingDetails.totalFreeCigaretteOnRelapse(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konsumsi Rokok"),
        backgroundColor: ColorConst.darkGreen,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SizeConst.pagePadding,
          child: Column(
            children: [
              BlocBuilder<SmokingDetailBloc, SmokingDetailState>(
                builder: (context, state) {
                  if (state is SmokingDetailsLoaded) {
                    return SectionStatisticDetailWidget(
                      child: CalendarTableWidget(
                        smokingDetails: state.smokingDetails,
                        user: widget.user,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              SectionStatisticDetailWidget(
                title: 'Jumlah rokok yang berhasil kamu hindari',
                child: Column(
                  children: [
                    SmokingFreeTotalCardWidget(
                      total: widget.smokingDetails
                          .totalFreeCigaretteOnRelapse(widget.user),
                    ),
                    SizedBox(height: 10.h),
                    ElevatedButton(
                      style: ButtonStyleConst.danger(),
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
                              children: [
                                AddSmokingDetailDialog(user: widget.user)
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Saya merokok hari ini"),
                    ),
                  ],
                ),
              ),
              SectionStatisticDetailWidget(
                title: 'Proyeksi',
                child: Column(
                  children: [
                    ProjectionChildWidget(
                      projectionType: ProjectionType.day,
                      user: widget.user,
                      totalFreeCigaretteOnRelapse: _totalFreeCigaretteOnRelapse,
                    ),
                    ProjectionChildWidget(
                      projectionType: ProjectionType.week,
                      user: widget.user,
                      totalFreeCigaretteOnRelapse: _totalFreeCigaretteOnRelapse,
                    ),
                    ProjectionChildWidget(
                      projectionType: ProjectionType.month,
                      user: widget.user,
                      totalFreeCigaretteOnRelapse: _totalFreeCigaretteOnRelapse,
                    ),
                    ProjectionChildWidget(
                      projectionType: ProjectionType.year,
                      user: widget.user,
                      totalFreeCigaretteOnRelapse: _totalFreeCigaretteOnRelapse,
                    ),
                  ],
                ),
              ),
              BlocBuilder<ConsumptionChartCubit, List<FlSpot>>(
                builder: (context, state) {
                  return SizedBox(
                    width: 350.w,
                    height: 200.h,
                    child: SectionStatisticDetailWidget(
                      title: 'Statistik',
                      child: Expanded(
                        child: ChartWidget(
                          chartType: ChartType.consumption,
                          data: state,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
