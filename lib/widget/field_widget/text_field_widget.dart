import 'package:berhentikok/base/form_field_decoration.dart';
import 'package:berhentikok/base/text_input_formatter_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String? hintText;
  final Widget? prefix;
  final TextAlign? textAlign;
  final int? maxLine;
  final bool isNumber;
  const TextFieldWidget({
    Key? key,
    required this.label,
    this.hintText,
    this.prefix,
    this.textAlign,
    this.maxLine,
    this.isNumber = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: TextField(
        textAlign: textAlign ?? TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        maxLines: maxLine,
        keyboardType: isNumber ? TextInputType.number : null,
        inputFormatters: isNumber
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                ThousandsSeparatorInputFormatter(),
              ]
            : null,
        decoration: FormDecoration.style(
          label: label,
          hintText: hintText,
          prefix: prefix,
        ),
      ),
    );
  }
}
