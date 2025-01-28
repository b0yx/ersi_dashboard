import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String title; // النص الظاهر في الحقل
  final List<String> items; // العناصر المتاحة في القائمة المنسدلة
  final String selectedItem; // العنصر الحالي المختار
  final ValueChanged<String> onChanged; // دالة استدعاء عند تغيير العنصر

  const CustomDropdownField({
    Key? key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // عرض القائمة المنسدلة
        final selected = await showModalBottomSheet<String>(
          context: context,
          builder: (BuildContext context) {
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(
                    item,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: item == selectedItem ? Colors.green : Colors.black,
                      fontWeight:
                      item == selectedItem ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context, item); // إعادة العنصر المختار
                  },
                );
              },
            );
          },
        );

        // استدعاء دالة تغيير العنصر
        if (selected != null && selected != selectedItem) {
          onChanged(selected);
        }
      },
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
