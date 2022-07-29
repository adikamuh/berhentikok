import 'package:berhentikok/base/form_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DateTimeFieldWidget extends StatelessWidget {
  final String label;
  final Widget? suffix;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  const DateTimeFieldWidget({
    Key? key,
    required this.label,
    this.suffix,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  static final DateFormat _dateFormat =
      DateFormat("d MMMM yyyy, HH:mm", 'id_ID');

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateTextController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(height: 8.h),
          TextFormField(
            // format: _dateFormat,
            decoration: FormDecoration.style(suffixIcon: suffix),
            validator: validator,
            onChanged: onChanged,
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              DateTime? date = await showDatePicker(
                context: context,
                firstDate: firstDate ?? DateTime.now(),
                initialDate: initialDate ?? DateTime.now(),
                lastDate:
                    lastDate ?? DateTime.now().add(const Duration(days: 30)),
              );
              if (date != null) {
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(initialDate ?? DateTime.now()),
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child!,
                    );
                  },
                );
                if (time != null) {
                  dateTextController.text = _dateFormat.format(DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  ));
                }
              }
            },
            // onShowPicker: (context, currentValue) async {
            //   DateTime? date = await showDatePicker(
            //     context: context,
            //     firstDate: firstDate ?? DateTime.now(),
            //     initialDate: currentValue ?? DateTime.now(),
            //     lastDate:
            //         lastDate ?? DateTime.now().add(const Duration(days: 30)),
            //   );
            //   if (date != null) {
            //     TimeOfDay? time = await showTimePicker(
            //       context: context,
            //       initialTime:
            //           TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            //       builder: (BuildContext context, Widget? child) {
            //         return MediaQuery(
            //           data: MediaQuery.of(context)
            //               .copyWith(alwaysUse24HourFormat: true),
            //           child: child!,
            //         );
            //       },
            //     );
            //     if (time != null) {
            //       return DateTimeField.combine(date, time);
            //     }
            //   }
            //   return null;
            // },
          ),
        ],
      ),
    );
  }
}
