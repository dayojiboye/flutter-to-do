import 'package:flutter/material.dart';
import 'package:to_do/utils/colors.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, right: 8.0),
      child: Column(
        children: [
          SwitchListTile.adaptive(
            value: false,
            title: const Text(
              "Switch to dark mode",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: kPrimaryTextColor,
              ),
            ),
            onChanged: (value) {},
          )
        ],
      ),
    );
  }
}
