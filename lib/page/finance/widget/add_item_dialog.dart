import 'package:berhentikok/widget/field_widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddItemDialog extends StatelessWidget {
  const AddItemDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Tambah Target Barang"),
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
              onPressed: () {},
              child: const Text('Batal'),
            ),
            SizedBox(width: 8.w),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Simpan'),
            ),
          ],
        ),
      ],
    );
  }
}
