import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/model/health_progress.dart';
import 'package:berhentikok/model/target_item.dart';
import 'package:berhentikok/page/consumption/consumption_page.dart';
import 'package:berhentikok/page/consumption/widget/smoking_free_total_card_widget.dart';
import 'package:berhentikok/page/finance/finance_page.dart';
import 'package:berhentikok/page/finance/widget/money_saved_card_widget.dart';
import 'package:berhentikok/page/finance/widget/target_item_card_widget.dart';
import 'package:berhentikok/page/health/health_page.dart';
import 'package:berhentikok/page/health/widget/health_card_widget.dart';
import 'package:berhentikok/page/statistic/widget/statistic_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({Key? key}) : super(key: key);
  static List<HealthProgress> healthProgresses = [
    const HealthProgress(
      icon: Icons.favorite,
      caption: 'Tekanan darah kembali normal',
      value: 50,
    ),
    const HealthProgress(
      icon: Icons.favorite,
      caption: 'Tekanan darah kembali normal',
      value: 50,
    ),
  ];

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
                children: [
                  HealthCardWidget(healthProgress: healthProgresses[0]),
                  SizedBox(height: 10.h),
                  HealthCardWidget(healthProgress: healthProgresses[1]),
                ],
              ),
            ),
            SizedBox(height: 12.h),
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
                children: [
                  const MoneySavedCardWidget(value: 'Rp 20.000'),
                  SizedBox(height: 10.h),
                  Row(
                    children: const [
                      TargetItemCardWidget(
                        targetItem:
                            TargetItem(name: "SSD 512GB", price: 650000),
                        moneySaved: 20000,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
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
                  SmokingFreeTotalCardWidget(total: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
