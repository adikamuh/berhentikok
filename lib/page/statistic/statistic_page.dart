import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/page/consumption/consumption_page.dart';
import 'package:berhentikok/page/finance/finance_page.dart';
import 'package:berhentikok/page/health/health_page.dart';
import 'package:berhentikok/page/statistic/widget/statistic_section_widget.dart';
import 'package:berhentikok/widget/card_widget/long_card_widget.dart';
import 'package:flutter/material.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: SizeConst.pagePadding,
        child: Column(
          children: [
            StatisticSectionWidget(
              title: 'Kesehatan',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const HealthPage()),
                  ),
                );
              },
              child: Column(
                children: const [
                  LongCardWidget(text: 'Tekanan darah kembali normal'),
                  LongCardWidget(text: 'Detak jantung kembali normal'),
                ],
              ),
            ),
            StatisticSectionWidget(
              title: 'Uang Tersimpan',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const FinancePage()),
                  ),
                );
              },
              child: Column(
                children: const [
                  LongCardWidget(text: 'Rp 20.000'),
                  LongCardWidget(text: 'SSD 512GB'),
                ],
              ),
            ),
            StatisticSectionWidget(
              title: 'Konsumsi Rokok',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const ConsumptionPage()),
                  ),
                );
              },
              child: Column(
                children: const [
                  LongCardWidget(text: '4 Rokok'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
