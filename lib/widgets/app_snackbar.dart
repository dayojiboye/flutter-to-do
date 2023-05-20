import 'package:flutter/material.dart';
import 'package:to_do/constants/enums.dart';
import 'package:to_do/utils/colors.dart';

class CustomSnackbar {
  const CustomSnackbar(
      {required this.context, required this.variant, required this.text});

  final BuildContext context;
  final SnackbarVariant variant;
  final String text;

  Color? get _getVariant {
    switch (variant) {
      case SnackbarVariant.ERROR:
        return kError;

      case SnackbarVariant.SUCCESS:
        return kSuccess;

      default:
        return null;
    }
  }

  void showFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _getVariant,
        content: Text(
          text,
          style: const TextStyle(
            color: kSecondaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
