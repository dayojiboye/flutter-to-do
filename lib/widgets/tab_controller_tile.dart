import 'package:flutter/material.dart';
import 'package:to_do/utils/colors.dart';

class TabControllerTile extends StatelessWidget {
  const TabControllerTile({
    super.key,
    this.leading,
    required this.title,
    required this.selected,
    required this.onTap,
    required this.modalContext,
  });

  final Widget? leading;
  final String title;
  final bool selected;
  final void Function() onTap;
  final BuildContext modalContext;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      selectedColor: kPrimaryColor,
      child: ListTile(
        leading: leading,
        title: Text(title),
        horizontalTitleGap: 0,
        selected: selected,
        selectedTileColor: kLightBlue,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 2,
        ),
        onTap: () {
          onTap();
          Navigator.of(modalContext).pop();
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
      ),
    );
  }
}
