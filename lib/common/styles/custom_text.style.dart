import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;

  const CustomText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        decoration: TextDecoration.none,
        color: Colors.black,
        fontSize: 18,
      ),
    );
  }
}
