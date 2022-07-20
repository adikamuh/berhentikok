import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/model/target_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TargetItemCardWidget extends StatelessWidget {
  final int moneySaved;
  final TargetItem targetItem;
  const TargetItemCardWidget({
    Key? key,
    required this.targetItem,
    required this.moneySaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(right: 10.w),
      color: ColorConst.lightGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
          child: Column(
            children: [
              Text(
                targetItem.name,
                style: FontConst.header3(color: ColorConst.darkGreen),
              ),
              SizedBox(height: 10.h),
              Text(
                "Rp $moneySaved / ${targetItem.toCurrencyFormatter()}",
                style: FontConst.body(color: ColorConst.darkGreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
