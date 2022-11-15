import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontConst {
  static TextStyle header1({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: color,
      fontSize: fontSize ?? 36.sp,
      fontWeight: fontWeight ?? FontWeight.w700,
    );
  }

  static TextStyle header2({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: color,
      fontSize: fontSize ?? 22.sp,
      fontWeight: fontWeight ?? FontWeight.w700,
    );
  }

  static TextStyle header3({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: color,
      fontSize: fontSize ?? 18.sp,
      fontWeight: fontWeight ?? FontWeight.w600,
    );
  }

  static TextStyle subtitle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: color,
      fontSize: fontSize ?? 16.sp,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }

  static TextStyle body({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: color,
      fontSize: fontSize ?? 14.sp,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }

  static TextStyle small({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: color,
      fontSize: fontSize ?? 12.sp,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }

  static TextStyle tiny({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: color,
      fontSize: fontSize ?? 10.sp,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }
}
