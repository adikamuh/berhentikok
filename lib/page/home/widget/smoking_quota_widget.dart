import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmokingQuotaWidget extends StatelessWidget {
  const SmokingQuotaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Container(
        decoration: const BoxDecoration(color: Color(0xffF5EFE8)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 18.w,
            horizontal: 18.w,
          ),
          child: Row(
            children: [
              Icon(
                Icons.smoking_rooms_rounded,
                color: Colors.black,
                size: 80.w,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Batas konsumsi rokokmu hari ini",
                      style: FontConst.small(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "8 Rokok",
                      style: FontConst.header2(
                        color: Colors.black,
                        fontSize: 26.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
