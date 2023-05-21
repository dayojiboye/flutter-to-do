import 'package:flutter/material.dart';

class AppBottomSheet {
  const AppBottomSheet({
    required this.context,
    required this.child,
    this.height,
    this.showDragHandle = true,
  });

  final BuildContext context;
  final Widget child;
  final double? height;
  final bool showDragHandle;

  void open() {
    showModalBottomSheet(
      context: context,
      showDragHandle: showDragHandle,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      builder: (ctx) => SizedBox(
        width: double.infinity,
        height: height,
        child: child,
      ),
    );
  }
}
