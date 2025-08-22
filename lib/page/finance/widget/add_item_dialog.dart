import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/base/string_extension.dart';
import 'package:berhentikok/model/target_item.dart';
import 'package:berhentikok/page/finance/bloc/add_item_bloc.dart';
import 'package:berhentikok/widget/field_widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  int? _price;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddItemBloc, AddItemState>(
      listener: (context, state) {
        if (state is ItemSubmitted) {
          context.read<AddItemBloc>().add(LoadItems());
          Navigator.of(context).pop();
        } else if (state is AddItemFailed) {
          state.errorMessage.showToast();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text("Tambah Target Barang", style: FontConst.header3()),
            SizedBox(height: 16.h),
            TextFieldWidget(
              label: 'Nama barang',
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama barang harus diisi.';
                }
                return null;
              },
            ),
            TextFieldWidget(
              label: 'Harga',
              isNumber: true,
              textAlign: TextAlign.end,
              prefix: const Text("Rp"),
              onChanged: (value) {
                setState(() {
                  _price = value.thousandFormatterToInt();
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harga barang harus diisi.';
                } else if (value.thousandFormatterToInt() <= 0) {
                  return 'Harga barang harus lebih dari 0';
                }
                return null;
              },
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
                    if (_formKey.currentState?.validate() ?? false) {
                      if (_name != null && _price != null) {
                        final TargetItem targetItem = TargetItem(
                          name: _name!,
                          price: _price!,
                        );
                        context.read<AddItemBloc>().add(SaveItem(targetItem));
                      }
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
