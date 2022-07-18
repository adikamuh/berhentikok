import 'package:berhentikok/base/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonStyleConst {
  static ButtonStyle primary() {
    return ElevatedButton.styleFrom(
      primary: ColorConst.primaryColor1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
    );
  }

  static ButtonStyle warning() {
    return ElevatedButton.styleFrom(
      elevation: 5,
      primary: Colors.red.shade900,
      onPrimary: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
    );
  }
}
