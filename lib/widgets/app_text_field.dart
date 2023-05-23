import 'package:flutter/material.dart';
import 'package:to_do/utils/colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.cursorColor = kMuted,
    this.style,
    this.hintText = "Placeholder",
    this.hintStyle,
    this.border = InputBorder.none,
    this.autoFocus = true,
    this.autoCorrect = true,
    this.textCapitalization = TextCapitalization.sentences,
    required this.controller,
    this.onChanged,
  });

  final Color cursorColor;
  final TextStyle? style;
  final String hintText;
  final TextStyle? hintStyle;
  final InputBorder border;
  final bool autoFocus;
  final bool autoCorrect;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      autocorrect: autoCorrect,
      cursorColor: cursorColor,
      textCapitalization: textCapitalization,
      style: style,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        border: border,
      ),
      controller: controller,
      onChanged: onChanged,
    );
  }
}
