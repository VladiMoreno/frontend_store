import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'general.input.dart';

class TextInput extends GeneralInput {
  final Function? validator;
  final String helperText;
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  final bool enabled;

  const TextInput({
    super.key,
    required super.width,
    required super.labelText,
    required this.currentFocus,
    required this.nextFocus,
    this.validator,
    super.controller,
    super.hintText,
    this.helperText = '',
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: width,
        maxHeight: 105,
      ),
      child: KeyboardListener(
        focusNode: currentFocus,
        onKeyEvent: (value) {
          if (value.runtimeType == KeyDownEvent &&
              value.logicalKey == LogicalKeyboardKey.tab) {
            if (currentFocus.hasFocus) {
              FocusScope.of(context).requestFocus(nextFocus);
            }
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 12,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              counterText: '',
            ),
            validator: (value) {
              if (validator != null) {
                return validator!(value);
              }
              return null;
            },
            enabled: enabled,
          ),
        ),
      ),
    );
  }
}
