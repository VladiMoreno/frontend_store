import 'package:flutter/material.dart';

class GeneralInput extends StatelessWidget {
  final double width;
  final String labelText;
  final String? hintText;
  final TextEditingController? controller;

  const GeneralInput({
    super.key,
    required this.width,
    required this.labelText,
    this.hintText = 'Ingresa el valor',
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GeneralInput(
      labelText: labelText,
      width: width,
    );
  }
}
