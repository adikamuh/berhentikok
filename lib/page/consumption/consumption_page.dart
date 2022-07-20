import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/page/consumption/widget/add_smoking_detail_dialog.dart';
import 'package:berhentikok/page/consumption/widget/calendar_table_widget.dart';
import 'package:berhentikok/page/consumption/widget/smoking_free_total_card_widget.dart';
import 'package:berhentikok/widget/chart_widget/chart_widget.dart';
import 'package:berhentikok/widget/section_widget/projection_child_widget.dart';
import 'package:berhentikok/widget/section_widget/section_statistic_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsumptionPage extends StatelessWidget {
  const ConsumptionPage({Key? key}) : super(key: key);

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
              const SectionStatisticDetailWidget(
                child: CalendarTableWidget(),
              ),
              SectionStatisticDetailWidget(
                title: 'Jumlah rokok yang berhasil kamu hindari',
                child: Column(
                  children: [
                    const SmokingFreeTotalCardWidget(total: 12),
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
                              children: const [AddSmokingDetailDialog()],
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
                  children: const [
                    ProjectionChildWidget(
                      caption: 'Dalam sehari',
                      value: '6 batang',
                    ),
                    ProjectionChildWidget(
                      caption: 'Dalam seminggu',
                      value: '42 batang',
                    ),
                    ProjectionChildWidget(
                      caption: 'Dalam sebulan',
                      value: '180 batang',
                    ),
                    ProjectionChildWidget(
                      caption: 'Dalam setahun',
                      value: '2.190 batang',
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 350.w,
                height: 200.h,
                child: const SectionStatisticDetailWidget(
                  title: 'Statistik',
                  child: Expanded(child: ChartWidget()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
