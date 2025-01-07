import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon; // الأيقونة
  final double size; // حجم الأيقونة
  final Color color; // لون الأيقونة
  final VoidCallback onPressed; // العملية عند الضغط
  final String? tooltip; // تلميح يظهر عند الضغط المطول (اختياري)

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 24.0,
    this.color = Colors.black,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: size, color: color),
      onPressed: onPressed,
      tooltip: tooltip,
    );
  }
}
