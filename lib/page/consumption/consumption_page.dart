import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/page/consumption/widget/calendar_table_widget.dart';
import 'package:berhentikok/widget/card_widget/long_card_widget.dart';
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SizeConst.pagePadding,
          child: Column(
            children: [
              const SectionStatisticDetailWidget(
                child: CalendarTableWidget(),
              ),
              const SectionStatisticDetailWidget(
                title: 'Jumlah rokok yang berhasil kamu hindari',
                child: LongCardWidget(text: '20 Rokok'),
              ),
              SectionStatisticDetailWidget(
                title: 'Proyeksi',
                child: Column(
                  children: const [
                    ProjectionChildWidget(
                      caption: 'Dalam sehari',
                      value: '6',
                    ),
                    ProjectionChildWidget(
                      caption: 'Dalam seminggu',
                      value: '42',
                    ),
                    ProjectionChildWidget(
                      caption: 'Dalam sebulan',
                      value: '180',
                    ),
                    ProjectionChildWidget(
                      caption: 'Dalam setahun',
                      value: '2.190',
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
