import 'package:flutter/material.dart';

class TouchableOpacity extends StatefulWidget {
  const TouchableOpacity({
    required this.child,
    this.onTap,
    this.onLongPress,
    this.decoration,
    this.width = 50,
    this.height = 50,
    this.padding,
    Key? key,
    this.behavior = HitTestBehavior.opaque,
    this.disabled = false,
    this.loading = false,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.backgroundColor = Colors.black,
    this.alignment = Alignment.center,
    this.opacity = 0.6,
  }) : super(key: key);

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final BoxDecoration? decoration;
  final HitTestBehavior behavior;
  final bool disabled;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapCancel;
  final Color backgroundColor;
  final bool loading;
  final AlignmentGeometry alignment;
  final double opacity;

  @override
  State<TouchableOpacity> createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity> {
  bool isTappedDown = false;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        behavior: widget.behavior,
        onTapDown: (tapDownDetails) {
          if (widget.disabled || widget.loading) {
            return;
          }

          setState(() {
            isTappedDown = true;
          });

          if (widget.onTapDown != null) {
            widget.onTapDown!();
          }
        },
        onTapUp: (tapUpDetails) {
          setState(() {
            isTappedDown = false;
          });

          if (widget.onTapUp != null) {
            widget.onTapUp!();
          }
        },
        onTapCancel: () {
          setState(() {
            isTappedDown = false;
          });

          if (widget.onTapCancel != null) {
            widget.onTapCancel!();
          }
        },
        onTap: widget.disabled || widget.loading ? null : widget.onTap,
        onLongPress:
            widget.disabled || widget.loading ? null : widget.onLongPress,
        child: AnimatedOpacity(
          opacity: isTappedDown ? widget.opacity : 1.0,
          duration: const Duration(milliseconds: 250),
          child: Container(
            alignment: widget.alignment,
            width: widget.width,
            height: widget.height,
            decoration: widget.decoration ??
                BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
            padding: widget.padding,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
