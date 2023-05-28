import 'package:flutter/material.dart';
import 'package:to_do/utils/colors.dart';

class AppEmptyView extends StatelessWidget {
  const AppEmptyView({
    super.key,
    required this.imagePath,
    required this.title,
    this.text,
  });

  final String imagePath;
  final String title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: MediaQuery.of(context).size.width / 2,
            height: 250,
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryTextColor,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (text != null)
            Text(
              (text!),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: kSecondaryTextColor,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}
