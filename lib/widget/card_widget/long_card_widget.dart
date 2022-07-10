import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LongCardWidget extends StatelessWidget {
  final String text;
  final bool isSuffixIconOn;
  final Function()? onTap;
  const LongCardWidget({
    Key? key,
    required this.text,
    this.isSuffixIconOn = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[800],
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              if (isSuffixIconOn)
                const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.white,
                )
            ],
          ),
        ),
      ),
    );
  }
}
