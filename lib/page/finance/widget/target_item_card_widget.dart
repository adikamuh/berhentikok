import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/model/target_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TargetItemCardWidget extends StatelessWidget {
  final int moneySaved;
  final TargetItem targetItem;
  final EdgeInsets? margin;
  const TargetItemCardWidget({
    Key? key,
    required this.targetItem,
    required this.moneySaved,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      margin: margin ?? EdgeInsets.only(right: 10.w),
      color: ColorConst.lightGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 182.w, maxWidth: 182.w),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        targetItem.name,
                        textAlign: TextAlign.center,
                        style: FontConst.header3(color: ColorConst.darkGreen),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        targetItem.toStringProgress(moneySaved),
                        textAlign: TextAlign.center,
                        style: FontConst.body(color: ColorConst.darkGreen),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
