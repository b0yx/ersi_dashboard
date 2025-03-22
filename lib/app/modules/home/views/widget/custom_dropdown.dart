import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String? dropdownLabel; // ليبل الدروب داون (اختياري)
  final List<String>? dropdownItems; // عناصر القائمة المنسدلة (اختياري)
  final String? selectedDropdownItem; // العنصر المحدد في القائمة المنسدلة (اختياري)
  final ValueChanged<String?>? onDropdownChanged; // دالة استدعاء عند تغيير القائمة المنسدلة (اختياري)

  final List<Map<String, dynamic>>? textFields; // قائمة بالحقول النصية (اختياري)

  const CustomDropdownField({
    Key? key,
    this.dropdownLabel,
    this.dropdownItems,
    this.selectedDropdownItem,
    this.onDropdownChanged,
    this.textFields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ الدروب داون مع الليبل
        if (dropdownItems != null && dropdownLabel != null)
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Expanded(
                  child: InkWell(
                    onTap: () async {
                      // عرض القائمة المنسدلة
                      final selected = await showModalBottomSheet<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return ListView.builder(
                            itemCount: dropdownItems!.length,
                            itemBuilder: (context, index) {
                              final item = dropdownItems![index];
                              return ListTile(
                                title: Text(
                                  textAlign: TextAlign.end,
                                  item,
                                  style: TextStyle(
                                    color: item == selectedDropdownItem ? Colors.green : Colors.black,
                                    fontWeight: item == selectedDropdownItem ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context, item);
                                },
                              );
                            },
                          );
                        },
                      );

                      if (selected != null && onDropdownChanged != null) {
                        onDropdownChanged!(selected);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015, horizontal: screenWidth * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              selectedDropdownItem ?? 'اختر من القائمة',
                               textAlign: TextAlign.center,),
                          const Icon(Icons.keyboard_arrow_down, color: Color(0xFF96E6B3)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15,),
                SizedBox(
                  width: screenWidth * 0.3, // عرض الليبل متكيف
                  child: Text(
                    dropdownLabel!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

        //  الحقول النصية مع الليبل بجانبها
        if (textFields != null)
          ...textFields!.map((field) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.3, // عرض الليبل متكيف
                    child: Text(
                      field['label'] ?? '',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: field['controller'],
                      keyboardType: field['keyboardType'] ?? TextInputType.text,
                      decoration: InputDecoration(
                        hintText: field['hintText'] ?? '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
      ],
    );
  }
}
