import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/page/smoking_cessation_method_detail/smoking_cessation_method_detail_page.dart';
import 'package:berhentikok/widget/card_widget/long_card_widget.dart';
import 'package:berhentikok/widget/dialog_widget/full_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmokingCessationMethodsPage extends StatefulWidget {
  const SmokingCessationMethodsPage({Key? key}) : super(key: key);

  @override
  State<SmokingCessationMethodsPage> createState() =>
      _SmokingCessationMethodsPageState();
}

class _SmokingCessationMethodsPageState
    extends State<SmokingCessationMethodsPage> {
  int _clickCount = 0;

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
              onTap: () {
                setState(() {
                  _clickCount++;
                });
              },
            ),
            SizedBox(height: 10.h),
            LongCardWidget(
              text: 'Mengurangi konsumsi rokok',
              isSuffixIconOn: true,
              onTap: () {
                setState(() {
                  _clickCount++;
                });
              },
            ),
            SizedBox(height: 10.h),
            LongCardWidget(
              text: 'Metode NRT (Nicotine Replacement Therapy)',
              isSuffixIconOn: true,
              onTap: () {
                setState(() {
                  _clickCount++;
                });
                showDialog(
                  context: context,
                  builder: (context) =>
                      const SmokingCessationMethodDetailPage(),
                );
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    if (_clickCount > 0) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    'Saya sudah mengerti!',
                    style: FontConst.body(
                      fontWeight: FontWeight.w600,
                      color: _clickCount > 0
                          ? ColorConst.darkGreen
                          : ColorConst.lightGreen,
                    ),
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