import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText; // النص التوضيحي
  final String? hintText; // نص المساعدة
  final TextInputType keyboardType; // نوع لوحة المفاتيح
  final TextEditingController? controller; // المتحكم في النص
  final bool obscureText; // إخفاء النص (مثل كلمات المرور)
  final FormFieldValidator<String>? validator; // التحقق من صحة المدخلات
  final ValueChanged<String>? onChanged; // تنفيذ عند تغيير النص
  final Widget? prefixIcon; // أيقونة في البداية
  final Widget? suffixIcon; // أيقونة في النهاية
  final Color? fillColor;
  final bool? filled;
  final IconData? iconData;
  final TextAlign textAlign;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;

  const CustomTextFormField({
    Key? key,
    this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.filled,
    this.textAlign = TextAlign.start,
    this.hintStyle,
    this.contentPadding,
    this.border,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: hintStyle,
        fillColor: fillColor,
        filled: filled,
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
        contentPadding: contentPadding ?? const EdgeInsets.all(12),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}






// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class CustomTextFormField extends StatefulWidget {
//   final String? labelText; // النص التوضيحي
//   final String? hintText; // نص المساعدة
//   final TextInputType keyboardType; // نوع لوحة المفاتيح
//   final String? initialValue; // النص المبدئي
//   final TextEditingController? controller; // المتحكم في النص
//   final bool obscureText; // إخفاء النص (مثل كلمات المرور)
//   final FormFieldValidator<String>? validator; // التحقق من صحة المدخلات
//   final ValueChanged<String>? onChanged; // تنفيذ عند تغيير النص
//   final Widget? prefixIcon; // أيقونة في البداية
//   final Widget? suffixIcon; // أيقونة في النهاية
//   final Color? fillColor;
//   final bool? filled;
//   final IconData? iconData;
//
//   final TextAlign textalign;
//   final TextStyle hintstyle;
//   final EdgeInsetsGeometry contentPadding;
//   final InputBorder? borders;
//
//   const CustomTextFormField({
//     super.key,
//     this.labelText,
//     this.hintText,
//     this.keyboardType = TextInputType.text,
//     this.initialValue,
//     required this.controller,
//     this.obscureText = false,
//     this.validator,
//     this.onChanged,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.fillColor,
//     this.filled,
//     required this.textalign,
//     required this.hintstyle,
//     required this.contentPadding,
//     this.borders,
//     this.iconData,
//   });
//
//   @override
//   _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
// }
//
// class _CustomTextFormFieldState extends State<CustomTextFormField> {
//   late FocusNode _focusNode;
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode = FocusNode();
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       focusNode: _focusNode, // إضافة FocusNode هنا
//       textAlign: widget.textalign,
//       controller: widget.controller,
//       initialValue: widget.controller == null ? widget.initialValue : null,
//       obscureText: widget.obscureText,
//       keyboardType: widget.keyboardType,
//       validator: widget.validator,
//       onChanged: widget.onChanged,
//       autofocus: true, // تأكيد ظهور لوحة المفاتيح تلقائيًا عند التركيز
//       decoration: InputDecoration(
//         labelText: widget.labelText,
//         hintText: widget.hintText,
//         hintStyle: widget.hintstyle,
//         fillColor: widget.fillColor,
//         filled: widget.filled,
//         border: widget.borders ?? OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding: widget.contentPadding,
//         prefixIcon: InkWell(),
//         suffixIcon: widget.suffixIcon,
//       ),
//     );
//   }
// }
