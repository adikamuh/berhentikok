import 'package:flutter/material.dart';

class ButtonPrimaryWidget extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const ButtonPrimaryWidget({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
