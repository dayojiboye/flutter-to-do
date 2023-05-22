import 'package:flutter/material.dart';
import 'package:to_do/enums/enums.dart';
import 'package:to_do/utils/colors.dart';

class AppSnackbar {
  const AppSnackbar({
    required this.context,
    required this.variant,
    required this.text,
    this.action,
  });

  final BuildContext context;
  final SnackbarVariant variant;
  final String text;
  final SnackBarAction? action;

  Color? get _getVariant {
    switch (variant) {
      case SnackbarVariant.ERROR:
        return kError;

      default:
        return null;
    }
  }

  void showFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _getVariant,
        behavior: SnackBarBehavior.floating,
        action: action,
        elevation: 0,
        content: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
