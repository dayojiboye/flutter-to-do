import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/utils/colors.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({
    super.key,
    this.radius = 10,
    this.animating = true,
    this.color = kPrimaryTextColor,
    this.backgroundColor = kBackGroundColor,
  });

  final double radius;
  final bool animating;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = Platform.isIOS || Platform.isMacOS;

    Widget renderWidget() {
      if (isCupertino) {
        return CupertinoActivityIndicator(
          radius: radius,
          animating: animating,
          color: color,
        );
      } else {
        return CircularProgressIndicator(
          color: color,
          backgroundColor: backgroundColor,
        );
      }
    }

    return renderWidget();
  }
}
