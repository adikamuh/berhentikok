import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/widget/field_widget/date_time_field_widget.dart';
import 'package:berhentikok/widget/field_widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSmokingDetailDialog extends StatelessWidget {
  const AddSmokingDetailDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextFieldWidget(
          label: 'Jumlah rokok yang kamu konsumsi',
          isNumber: true,
        ),
        const DateTimeFieldWidget(
          label: 'Kapan kamu terakhir merokok',
        ),
        const TextFieldWidget(
          label: 'Kenapa kamu merokok kembali',
          maxLine: 3,
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ButtonStyleConst.danger(),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            SizedBox(width: 8.w),
            ElevatedButton(
              style: ButtonStyleConst.primary(),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ],
    );
  }
}
