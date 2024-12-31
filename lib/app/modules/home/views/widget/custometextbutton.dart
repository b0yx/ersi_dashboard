import 'package:flutter/material.dart';



class CustomTextButton {
  final double defaultFontSize;
  final Color defaultColor;
  final Color defaultBackgroundColor;
  final Widget? defaultIcon; // Default icon

  // Constructor for customizability
  CustomTextButton({
    this.defaultFontSize = 14.0,
    this.defaultColor = Colors.black,
    this.defaultBackgroundColor = Colors.transparent,
    this.defaultIcon = const Icon(null), // Default icon value
  });

  // Create a custom TextButton with optional icon
  TextButton textButton({
    required String label,
    required VoidCallback onPressed,
    double? fontSize,
    Color? textColor,
    Color? backgroundColor,
    Widget? icon, // Pass an optional icon here
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? defaultColor,
        backgroundColor: backgroundColor ?? defaultBackgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon??const Icon(null), // Use provided icon or default
          const SizedBox(width: 8), // Add spacing between icon and text
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize ?? defaultFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
