import 'package:flutter/material.dart';
import 'custometext.dart';

class CustomBottomSheet extends StatelessWidget {
  final List<String> options;
  final Function(String) onSelect;

  const CustomBottomSheet({
    Key? key,
    required this.options,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: options.map((option) {
          return ListTile(
            title: CustomText(
              text: option,
              textAlign: TextAlign.right,
              maxLine: 1,
            ),
            onTap: () => onSelect(option),
          );
        }).toList(),
      ),
    );
  }
}
