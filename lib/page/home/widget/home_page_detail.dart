import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/page/achievement/achievement_page.dart';
import 'package:berhentikok/page/consumption/widget/smoking_free_duration_card.dart';
import 'package:berhentikok/page/health/widget/linear_indicator.dart';
import 'package:berhentikok/page/home/widget/tips_dialog.dart';
import 'package:berhentikok/page/smoking_cessation_methods/smoking_cessation_methods_page.dart';
import 'package:berhentikok/widget/card_widget/box_card_widget.dart';
import 'package:berhentikok/widget/card_widget/long_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageDetail extends StatelessWidget {
  const HomePageDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context),
          SizedBox(height: 18.h),
          Padding(
            padding: SizeConst.pagePadding,
            child: Column(
              children: [
                _buildConsumptionSummary(context),
                SizedBox(height: 18.h),
                _buildOverallSummary(),
                SizedBox(height: 18.h),
                _buildOthers(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
        color: ColorConst.darkGreen,
      ),
      child: Stack(
        children: [
          Positioned(
            top: -80.w,
            left: -120.w,
            child: Container(
              width: 250.w,
              height: 250.w,
              decoration: const BoxDecoration(
                color: Color(0xff4B8A64),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: SizeConst.pagePadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, John Doe",
                        style: FontConst.header1(color: Colors.white),
                      ),
                      Text(
                        "Ingat terus untuk tetap berhenti merokok karena kamu ingin uangmu dihabiskan dengan cukup baik!",
                        style: FontConst.subtitle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30.w),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const AchievementPage())));
                  },
                  child: const Icon(
                    Icons.stars_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsumptionSummary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Expanded(
              child: SmokingFreeDurationCard(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverallSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overall Progress',
          style: FontConst.header2(color: ColorConst.blackColor2),
        ),
        SizedBox(height: 12.h),
        BoxCardWidget(
          child: Row(
            children: [
              Icon(
                Icons.favorite,
                size: 40.w,
                color: Colors.white,
              ),
              SizedBox(width: 24.w),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Tekanan darah kembali normal',
                      style: FontConst.subtitle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    const LinearIndicator(value: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.w),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BoxCardWidget(
                child: Column(
                  children: [
                    Icon(
                      Icons.savings_rounded,
                      color: Colors.white,
                      size: 40.w,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Rp 12.000',
                      style: FontConst.subtitle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: BoxCardWidget(
                child: Column(
                  children: [
                    Icon(
                      Icons.smoke_free,
                      color: Colors.white,
                      size: 40.w,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '12 batang rokok',
                      style: FontConst.subtitle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOthers(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lainnya",
          style: FontConst.header2(color: ColorConst.blackColor2),
        ),
        SizedBox(height: 12.h),
        LongCardWidget(
          text: "Baca Tips",
          backgroundColor: ColorConst.lightGreen,
          textColor: ColorConst.darkGreen,
          isSuffixIconOn: true,
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  children: const [TipsDialog()],
                );
              },
            );
          },
        ),
        SizedBox(height: 8.h),
        LongCardWidget(
          text: "Cara-cara untuk berhenti merokok",
          backgroundColor: ColorConst.lightGreen,
          textColor: ColorConst.darkGreen,
          isSuffixIconOn: true,
          onTap: () {
            _showSmokingCessationMethods(context: context, isFirst: false);
          },
        ),
      ],
    );
  }

  void _showSmokingCessationMethods({
    required BuildContext context,
    bool isFirst = true,
  }) {
    showDialog(
      barrierDismissible: isFirst ? false : true,
      context: context,
      builder: (context) => const SmokingCessationMethodsPage(),
    );
  }
}
