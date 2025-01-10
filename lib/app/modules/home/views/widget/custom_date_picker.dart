import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime selectedDate; // التاريخ الحالي
  final ValueChanged<DateTime> onDateChanged; // الإجراء عند تغيير التاريخ

  const CustomDatePicker({
    Key? key,
    required this.selectedDate,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2026),
        );
        if (picked != null && picked != selectedDate) {
          onDateChanged(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today,
              color: Color(0xFF96E6B3),
            ),
            const Spacer(),
            Text(
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
