import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String title; // النص الظاهر في الحقل
  final VoidCallback onTap; // الحدث عند النقر

  const CustomDropdownField({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF96E6B3),
          ),
        ),
      ),
    );
  }
}
