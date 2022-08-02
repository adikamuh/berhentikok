import 'package:berhentikok/base/form_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DateTimeFieldWidget extends StatefulWidget {
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
  State<DateTimeFieldWidget> createState() => _DateTimeFieldWidgetState();
}

class _DateTimeFieldWidgetState extends State<DateTimeFieldWidget> {
  final TextEditingController dateTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateTextController.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(dateTextController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label),
          SizedBox(height: 8.h),
          TextFormField(
            controller: dateTextController,
            decoration: FormDecoration.style(suffixIcon: widget.suffix),
            validator: widget.validator,
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              DateTime? date = await showDatePicker(
                context: context,
                firstDate: widget.firstDate ?? DateTime.now(),
                initialDate: widget.initialDate ?? DateTime.now(),
                lastDate: widget.lastDate ??
                    DateTime.now().add(const Duration(days: 30)),
              );
              if (date != null) {
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(
                      widget.initialDate ?? DateTime.now()),
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child!,
                    );
                  },
                );
                if (time != null) {
                  final text = DateTimeFieldWidget._dateFormat.format(DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  ));
                  dateTextController.text = text;
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
