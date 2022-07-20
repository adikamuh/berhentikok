import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/model/target_item.dart';
import 'package:berhentikok/page/finance/widget/add_item_dialog.dart';
import 'package:berhentikok/page/finance/widget/money_saved_card_widget.dart';
import 'package:berhentikok/page/finance/widget/target_item_card_widget.dart';
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
        backgroundColor: ColorConst.darkGreen,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SizeConst.pagePadding,
          child: Column(
            children: [
              const SectionStatisticDetailWidget(
                title: 'Kamu berhasil menghemat',
                child: MoneySavedCardWidget(value: "Rp 20.000"),
              ),
              SectionStatisticDetailWidget(
                title: 'Target Barang',
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: const [
                          TargetItemCardWidget(
                            targetItem: TargetItem(
                              name: 'SSD 512GB',
                              price: 650000,
                            ),
                            moneySaved: 20000,
                          ),
                          TargetItemCardWidget(
                            targetItem: TargetItem(
                              name: 'SSD 512GB',
                              price: 650000,
                            ),
                            moneySaved: 20000,
                          ),
                          TargetItemCardWidget(
                            targetItem: TargetItem(
                              name: 'SSD 512GB',
                              price: 650000,
                            ),
                            moneySaved: 20000,
                          ),
                          TargetItemCardWidget(
                            targetItem: TargetItem(
                              name: 'SSD 512GB',
                              price: 650000,
                            ),
                            moneySaved: 20000,
                          ),
                          TargetItemCardWidget(
                            targetItem: TargetItem(
                              name: 'SSD 512GB',
                              price: 650000,
                            ),
                            moneySaved: 20000,
                          ),
                        ],
                      ),
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
                            children: const [
                              Text('Tambah Barang'),
                              Icon(Icons.add_rounded),
                            ],
                          ),
                        ),
                      ],
                    )
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
