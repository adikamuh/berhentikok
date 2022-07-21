import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/widget/field_widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddItemDialog extends StatelessWidget {
  const AddItemDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Tambah Target Barang",
          style: FontConst.header3(),
        ),
        SizedBox(height: 16.h),
        const TextFieldWidget(label: 'Nama barang'),
        const TextFieldWidget(
          label: 'Harga',
          isNumber: true,
          prefix: Text("Rp"),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ButtonStyleConst.danger(),
              onPressed: () {},
              child: const Text('Batal'),
            ),
            SizedBox(width: 8.w),
            ElevatedButton(
              style: ButtonStyleConst.primary(),
              onPressed: () {},
              child: const Text('Simpan'),
            ),
          ],
        ),
      ],
    );
  }
}
