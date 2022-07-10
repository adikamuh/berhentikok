import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/widget/button_widget/button_primary_widget.dart';
import 'package:berhentikok/widget/card_widget/box_card_widget.dart';
import 'package:berhentikok/widget/card_widget/long_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageDetail extends StatelessWidget {
  const HomePageDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: SizeConst.pagePadding,
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 16.h),
            _buildConsumptionSummary(),
            SizedBox(height: 16.h),
            _buildOverallSummary(),
            SizedBox(height: 16.h),
            const LongCardWidget(text: "Baca Tips"),
            SizedBox(height: 8.h),
            const LongCardWidget(text: "Cara-cara untuk berhenti merokok"),
          ],
        ),
      ),
    );
  }
   Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Hi, John Doe"),
              Text(
                "Ingat terus untuk tetap berhenti merokok karena kamu ingin uangmu dihabiskan dengan cukup baik!",
              ),
            ],
          ),
        ),
        SizedBox(width: 30.w),
        const InkWell(
          child: Icon(Icons.stars_rounded),
        ),
      ],
    );
  }

  Widget _buildConsumptionSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Kamu sudah berhenti merokok selama"),
        const LongCardWidget(text: '1 hari 2 jam 4 menit'),
        Row(
          children: [
            Expanded(
              child: ButtonPrimaryWidget(
                text: 'Saya merokok hari ini',
                onPressed: () {},
              ),
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
        const Text('Overall Progress'),
        BoxCardWidget(
          child: Row(
            children: [
              const Icon(Icons.favorite),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  children: const [
                    Text('Tekanan darah kembali normal'),
                    LinearProgressIndicator(value: 0.5),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        BoxCardWidget(
          child: Row(
            children: [
              const Text("Rp"),
              SizedBox(width: 14.w),
              const Expanded(child: Text('12.000')),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        BoxCardWidget(
          child: Row(
            children: [
              const Icon(Icons.smoke_free),
              SizedBox(width: 14.w),
              const Expanded(child: Text('12 batang rokok')),
            ],
          ),
        ),
      ],
    );
  }
}
