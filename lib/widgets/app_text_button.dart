import 'package:flutter/material.dart';
import 'package:to_do/utils/colors.dart';
import 'package:to_do/widgets/touchable_opacity.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.text,
    this.textStyle,
    this.onTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.behavior,
    this.disabled = false,
  });

  final String text;
  final TextStyle? textStyle;
  final bool disabled;
  final HitTestBehavior? behavior;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapCancel;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onLongPress: onLongPress,
      disabled: disabled,
      width: null,
      height: null,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(),
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
              color: disabled ? kMuted : kPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
