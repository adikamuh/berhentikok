import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/widget/field_widget/date_time_field_widget.dart';
import 'package:berhentikok/widget/field_widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const TextFieldWidget(label: 'Nama'),
                    const TextFieldWidget(
                      label: 'Konsumsi rokok per hari',
                      isNumber: true,
                    ),
                    const TextFieldWidget(
                      label: 'Rata-rata harga rokok sebungkus',
                      prefix: Text('Rp'),
                      textAlign: TextAlign.end,
                      isNumber: true,
                    ),
                    const DateTimeFieldWidget(label: 'Mulai berhenti merokok'),
                    const TextFieldWidget(
                      label: 'Motivasi untuk berhenti merokok',
                      hintText:
                          'Contoh: karena ingin uang saya dihabiskan dengan cukup baik',
                      maxLine: 3,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyleConst.primary(),
                            onPressed: () async {
                              Navigator.of(context)
                                  .pushReplacementNamed('/home');
                            },
                            child: const Text('Simpan'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
