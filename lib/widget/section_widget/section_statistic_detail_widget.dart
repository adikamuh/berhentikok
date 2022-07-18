import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionStatisticDetailWidget extends StatelessWidget {
  final String? title;
  final Widget child;
  const SectionStatisticDetailWidget({
    Key? key,
    this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        children: [
          if (title != null) Text(title!),
          if (title != null) SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }
}
