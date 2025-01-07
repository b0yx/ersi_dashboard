import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {


  final String? labelText; // النص التوضيحي
  final String? hintText; // نص المساعدة
  final TextInputType keyboardType; // نوع لوحة المفاتيح
  final String? initialValue; // النص المبدئي
  final TextEditingController? controller; // المتحكم في النص
  final bool obscureText; // إخفاء النص (مثل كلمات المرور)
  final FormFieldValidator<String>? validator; // التحقق من صحة المدخلات
  final ValueChanged<String>? onChanged; // تنفيذ عند تغيير النص
  final Widget? prefixIcon; // أيقونة في البداية
  final Widget? suffixIcon; // أيقونة في النهاية
  final Color?fillColor;
  final bool?filled;
  final TextAlign textalign;
  final TextStyle hintstyle;
  final EdgeInsetsGeometry contentPadding ;
  final InputBorder? borders;


  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.initialValue,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.filled,
    required this.textalign,
    required this.hintstyle,
    required this.contentPadding,
    this.borders,


  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textalign,
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle:hintstyle ,
        fillColor:fillColor ,
        filled: filled,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none),
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),

    );

  }
}
