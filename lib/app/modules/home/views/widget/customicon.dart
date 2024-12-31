import 'package:ersei/app/core/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomIcons {
  final double defaultSize;
  final Color defaultColor;

  // Constructor for customizability
  CustomIcons({
    this.defaultSize = 20,
    this.defaultColor =ColorsApp.greencolorapp ,
  });

  // Icon widget for a single icon
  Widget icon(IconData iconData, {double? size, Color? color}) {
    return Icon(
      iconData,
      size: size ?? defaultSize,
      color: color ?? defaultColor,
    );
  }
}
