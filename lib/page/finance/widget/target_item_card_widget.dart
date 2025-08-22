import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/base/int_extension.dart';
import 'package:berhentikok/model/target_item.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/finance/widget/target_item_detail_dialog.dart';
import 'package:berhentikok/page/health/widget/linear_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TargetItemCardWidget extends StatelessWidget {
  final int moneySaved;
  final TargetItem targetItem;
  final User user;
  final EdgeInsets? margin;
  const TargetItemCardWidget({
    super.key,
    required this.targetItem,
    required this.user,
    required this.moneySaved,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: ColorConst.lightGreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: InkWell(
        onTap: () async {
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
                  TargetItemDetailDialog(
                    targetItem: targetItem,
                    moneySaved: moneySaved,
                    user: user,
                  ),
                ],
              );
            },
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      targetItem.name,
                      style: FontConst.header3(color: Colors.black),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Colors.black,
                    size: 20.w,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      moneySaved >= targetItem.price
                          ? targetItem.price.toCurrencyFormatter()
                          : moneySaved.toCurrencyFormatter(),
                      style: FontConst.body(
                        color: const Color(0xff767676),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${targetItem.toPercentProgress(moneySaved)} %",
                      textAlign: TextAlign.end,
                      style: FontConst.body(
                        color: ColorConst.darkGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: LinearIndicator(
                      value: targetItem.toPercentProgress(moneySaved),
                      valueColor: ColorConst.darkGreen,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
