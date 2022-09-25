import 'package:berhentikok/base/form_field_decoration.dart';
import 'package:berhentikok/base/text_input_formatter_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final String? hintText;
  final String? helperText;
  final String? initialValue;
  final Widget? prefix;
  final TextAlign? textAlign;
  final int? maxLine;
  final bool isNumber;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  const TextFieldWidget({
    Key? key,
    required this.label,
    this.hintText,
    this.helperText,
    this.initialValue,
    this.prefix,
    this.textAlign,
    this.maxLine,
    this.isNumber = false,
    this.validator,
    this.onChanged,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
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
            textAlign: widget.textAlign ?? TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            maxLines: widget.maxLine ?? 1,
            keyboardType: widget.isNumber ? TextInputType.number : null,
            validator: widget.validator,
            onChanged: widget.onChanged,
            initialValue: widget.initialValue,
            inputFormatters: widget.isNumber
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    ThousandsSeparatorInputFormatter(),
                  ]
                : null,
            decoration: FormDecoration.style(
              hintText: widget.hintText,
              prefix: widget.prefix,
              helperText: widget.helperText,
            ),
            textInputAction: widget.textInputAction,
          ),
        ],
      ),
    );
  }
}
