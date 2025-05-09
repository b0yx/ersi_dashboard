import 'dart:io';
import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/modules/home/views/widget/custom_dropdown.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:flutter/material.dart';
import 'custom_checkbox.dart';

class CustomImageMulForm extends StatelessWidget {
  final String formName;
  final String? sectionName;
  final String? firstImageLabel;
  final String? secondImageLabel;
  /// الآن نستقبل مسارات الصور بدلاً من كائنات XFile
  final String? firstImagePath;
  final String? secondImagePath;
  /// دوال اختيار الصور التي يتم ربطها بالكنترولر العام
  final VoidCallback onPickFirstImage;
  final VoidCallback onPickSecondImage;
  final List<CustomDropdownField> dropdowns;
  final List<CustomCheckboxField> checkboxes;

  const CustomImageMulForm({
    Key? key,
    required this.formName,
    this.sectionName,
    this.firstImageLabel,
    this.secondImageLabel,
    this.firstImagePath,
    this.secondImagePath,
    required this.onPickFirstImage,
    required this.onPickSecondImage,
    this.dropdowns = const [],
    this.checkboxes = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          CustomText(
            maxLine: 1,
            alignment: Alignment.center,
            color: ColorsApp.blackColor,
            text: formName,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          CustomText(
            maxLine: 1,
            alignment: Alignment.center,
            color: ColorsApp.greencolorapp,
            text: sectionName ?? '',
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildImageContainer(
                title: firstImageLabel ?? '1',
                imagePath: firstImagePath,
                onTap: onPickFirstImage,
              ),
              buildImageContainer(
                title: secondImageLabel ?? '2',
                imagePath: secondImagePath,
                onTap: onPickSecondImage,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // عرض القوائم المنسدلة
          ...dropdowns.map((dropdown) => Padding(
            padding: const EdgeInsets.only(top: 10),
            child: dropdown,
          )),
          const SizedBox(height: 20),
          // عرض مربعات الاختيار
          ...checkboxes.map((checkbox) => Padding(
            padding: const EdgeInsets.only(top: 10),
            child:Row(
              children: [
                checkbox,
                const SizedBox(width: 10),
                CustomText(
                  maxLine: 1,
                  alignment: Alignment.center,
                  color: ColorsApp.blackColor,
                  text: checkbox.label,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget buildImageContainer({
    required String title,
    required String? imagePath,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              image: imagePath != null
                  ? DecorationImage(
                image: FileImage(File(imagePath)),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: imagePath == null
                ? const Icon(
              Icons.add_photo_alternate_outlined,
              size: 40,
              color: Colors.grey,
            )
                : null,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
