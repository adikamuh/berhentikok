import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/widget/card_widget/box_card_widget.dart';
import 'package:berhentikok/widget/card_widget/long_card_widget.dart';
import 'package:berhentikok/widget/chart_widget/chart_widget.dart';
import 'package:berhentikok/widget/section_widget/projection_child_widget.dart';
import 'package:berhentikok/widget/section_widget/section_statistic_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uang Tersimpan"),
      ),
      body: Padding(
        padding: SizeConst.pagePadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SectionStatisticDetailWidget(
                title: 'Kamu berhasil menghemat',
                child: LongCardWidget(text: 'Rp 20.000'),
              ),
              SectionStatisticDetailWidget(
                title: 'Target Barang',
                child: Row(
                  children: [
                    BoxCardWidget(
                      child: Column(
                        children: const [
                          Text("SSD 512 GB"),
                          Text('Rp 20.000/650.000'),
                        ],
                      ),
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
                      value: 'Rp7.000',
                    ),
                    ProjectionChildWidget(
                      caption: 'Dalam seminggu',
                      value: 'Rp49.000',
                    ),
                    ProjectionChildWidget(
                      caption: 'Dalam sebulan',
                      value: 'Rp210.000',
                    ),
                    ProjectionChildWidget(
                      caption: 'Dalam setahun',
                      value: 'Rp2.555.000',
                    ),
                  ],
                ),
              ),
              SectionStatisticDetailWidget(
                title: 'Statistik',
                child: SizedBox(
                  width: 350.w,
                  height: 200.h,
                  child: const ChartWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
