import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:flutter/material.dart';

class StatisticSectionWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final Function()? onTap;
  const StatisticSectionWidget({
    Key? key,
    required this.title,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: FontConst.header2(color: ColorConst.blackColor2),
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
          child,
        ],
      ),
    );
  }
}
