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
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Expanded(child: Text(title)),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
        child,
      ],
    );
  }
}
