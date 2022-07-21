import 'package:flutter/material.dart';

class ProjectionChildWidget extends StatelessWidget {
  final String caption;
  final String value;
  const ProjectionChildWidget({
    Key? key,
    required this.caption,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(caption),
        Text(value),
      ],
    );
  }
}
