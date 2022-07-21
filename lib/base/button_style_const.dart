import 'package:berhentikok/base/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonStyleConst {
  static ButtonStyle primary() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      primary: ColorConst.darkGreen,
      onPrimary: ColorConst.lightGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
    );
  }

  static ButtonStyle secondary() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      primary: ColorConst.lightGreen,
      onPrimary: ColorConst.darkGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
    );
  }

  static ButtonStyle warning() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      primary: Colors.red.shade900,
      onPrimary: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
    );
  }

  static ButtonStyle danger() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      primary: ColorConst.lightRed,
      onPrimary: ColorConst.darkRed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
    );
  }
}
