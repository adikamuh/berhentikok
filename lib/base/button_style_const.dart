import 'package:berhentikok/base/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonStyleConst {
  static ButtonStyle primary() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: ColorConst.darkGreen,
      foregroundColor: ColorConst.lightGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
    );
  }

  static ButtonStyle secondary() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: ColorConst.lightGreen,
      foregroundColor: ColorConst.darkGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
    );
  }

  static ButtonStyle warning() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.red.shade900,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
    );
  }

  static ButtonStyle danger() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: ColorConst.lightRed,
      foregroundColor: ColorConst.darkRed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
    );
  }
}
