import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/page/consumption/widget/add_smoking_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmokingFreeDurationCard extends StatelessWidget {
  const SmokingFreeDurationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Container(
        decoration: const BoxDecoration(color: ColorConst.darkGreen),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 18.w,
                horizontal: 18.w,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 180.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kamu sudah berhenti merokok selama",
                          style: FontConst.body(color: ColorConst.lightGreen),
                        ),
                        SizedBox(height: 18.h),
                        Text(
                          "1 hari 2 jam",
                          style: FontConst.header1(
                            color: Colors.white,
                            fontSize: 30.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.timer_outlined,
                    color: const Color(0xff589370),
                    size: 100.w,
                  ),
                ],
              ),
            ),
            InkWell(
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
                      children: const [AddSmokingDetailDialog()],
                    );
                  },
                );
              },
              child: Container(
                color: ColorConst.lightGreen,
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Saya merokok lagi hari ini ",
                      style: FontConst.body(
                        color: ColorConst.darkRed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(
                      Icons.sentiment_dissatisfied,
                      color: ColorConst.darkRed,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
