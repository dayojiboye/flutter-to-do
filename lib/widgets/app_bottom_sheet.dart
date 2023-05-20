import 'package:flutter/material.dart';
import 'package:to_do/utils/colors.dart';
import 'package:to_do/utils/dimension.dart';

class CustomBottomsheet {
  const CustomBottomsheet({
    required this.context,
    required this.child,
  });

  final BuildContext context;
  final Widget child;

  void open() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SizedBox(
        width: double.infinity,
        height: SizeConfig.screenHeight, // testing
        child: Padding(
          // padding: const EdgeInsets.all(12),
          padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
          child: Column(
            children: [
              // bottom sheet top handle
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kMuted,
                ),
              ),
              const SizedBox(height: 20),
              // inner child widget
              child
            ],
          ),
        ),
      ),
    );
  }
}
