import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormDecoration {
  static InputDecoration style({
    String? label,
    String? hintText,
    Widget? prefix,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hintText,
      alignLabelWithHint: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      prefix: prefix,
      suffixIcon: suffixIcon,
      isDense: true,
    );
  }
}
