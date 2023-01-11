import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/base/int_extension.dart';
import 'package:berhentikok/model/target_item.dart';
import 'package:berhentikok/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:round_spot/round_spot.dart';

class TargetItemDetailDialog extends StatelessWidget {
  final TargetItem targetItem;
  final int moneySaved;
  final User user;
  const TargetItemDetailDialog({
    Key? key,
    required this.targetItem,
    required this.moneySaved,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Detector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            targetItem.name,
            style: FontConst.header2(),
          ),
          SizedBox(height: 40.h),
          CircularPercentIndicator(
            radius: 80.w,
            lineWidth: 18,
            circularStrokeCap: CircularStrokeCap.round,
            percent: targetItem.toPercentProgress(moneySaved) / 100,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  moneySaved.toCurrencyFormatter(),
                  style: FontConst.small(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade700,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  width: 40.w,
                  height: 1,
                  color: ColorConst.greyColor2,
                ),
                Text(
                  targetItem.price.toCurrencyFormatter(),
                  style: FontConst.body(
                    fontWeight: FontWeight.w600,
                    color: ColorConst.darkGreen,
                  ),
                ),
              ],
            ),
            progressColor: ColorConst.darkGreen,
            backgroundColor: ColorConst.lightGreen,
          ),
          SizedBox(height: 40.h),
          Text(
            'Estimasi tercapai ${targetItem.estimateDays(moneySaved, user)} hari lagi jika kamu terus berhenti merokok',
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyleConst.danger(),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tutup'),
              ),
            ],
          ),
        ],
      ),
      areaID: "target-item-detail-dialog",
    );
  }
}
