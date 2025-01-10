import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;

  final double fontSize;

  final Color color;
  final FontWeight? fontWeight;
  final Alignment alignment;

  final int maxLine;
  final double height;
  final TextAlign textAlign; // محاذاة النص (يمين، يسار، وسط...)


  const CustomText({
    this.text = '',
    this.fontSize = 16,
    this.color = Colors.black,
    this.fontWeight ,
    this.alignment = Alignment.topLeft,
    required this.maxLine,
    this.height = 1,
    this.textAlign = TextAlign.start, // القيمة الافتراضية
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          height: height,
          fontSize: fontSize,
          fontWeight:null ,
        ),
        maxLines: maxLine,
      ),
    );
  }
}