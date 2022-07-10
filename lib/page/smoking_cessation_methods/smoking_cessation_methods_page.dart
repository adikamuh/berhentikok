import 'package:berhentikok/page/smoking_cessation_method_detail/smoking_cessation_method_detail_page.dart';
import 'package:berhentikok/widget/button_widget/button_primary_widget.dart';
import 'package:berhentikok/widget/card_widget/long_card_widget.dart';
import 'package:berhentikok/widget/dialog_widget/full_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmokingCessationMethodsPage extends StatelessWidget {
  const SmokingCessationMethodsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FullDialogWidget(
      appBarTitle: 'Metode Berhenti Merokok',
      isShowLeadingIcon: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            LongCardWidget(
              text: 'Berhenti seketika',
              isSuffixIconOn: true,
              onTap: () {},
            ),
            SizedBox(height: 10.h),
            LongCardWidget(
              text: 'Mengurangi konsumsi rokok',
              isSuffixIconOn: true,
              onTap: () {},
            ),
            SizedBox(height: 10.h),
            LongCardWidget(
              text: 'Metode NRT (Nicotine Replacement Therapy)',
              isSuffixIconOn: true,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      const SmokingCessationMethodDetailPage(),
                );
              },
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ButtonPrimaryWidget(
                    text: 'Saya sudah mengerti!',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
