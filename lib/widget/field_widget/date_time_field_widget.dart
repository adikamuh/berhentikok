import 'package:berhentikok/base/form_field_decoration.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DateTimeFieldWidget extends StatelessWidget {
  final String label;
  final Widget? suffix;
  const DateTimeFieldWidget({
    Key? key,
    required this.label,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: DateTimeField(
        format: DateFormat('yyyy-MM-dd'),
        decoration: FormDecoration.style(label: label, suffixIcon: suffix),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)),
          );
        },
      ),
    );
  }
}
