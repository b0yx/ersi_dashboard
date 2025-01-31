import 'dart:io';
import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/modules/home/views/widget/custom_dropdown.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageMulForm extends StatelessWidget {
  final String formName;
  final String? sectionName;
  final String? firstImageName;
  final String? secondImageName;
  final XFile? firstImage;
  final XFile? secondImage;
  final VoidCallback onPickFirstImage;
  final VoidCallback onPickSecondImage;
  final List<CustomDropdownField> dropdowns; // ✅ إضافة قائمة الـ Dropdowns

  const CustomImageMulForm({
    super.key,
    required this.firstImage,
    required this.secondImage,
    required this.onPickFirstImage,
    required this.onPickSecondImage,
    required this.formName,
    this.sectionName,
    this.dropdowns = const [],
    this.firstImageName,
    this.secondImageName, // ✅ جعلها اختيارية بحيث يمكن تمرير أي عدد من القوائم
  });

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
            text: sectionName??'',
          ),
          const SizedBox(height: 20),
          /// ✅ صور المخطط والمنفذ
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildImageContainer(
                title: firstImageName??'1',
                image: firstImage,
                onTap: onPickFirstImage,
              ),
              buildImageContainer(
                title: secondImageName??'2',
                image: secondImage,
                onTap: onPickSecondImage,
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// ✅ عرض القوائم المنسدلة بشكل ديناميكي
          ...dropdowns.map((dropdown) => Padding(
            padding: const EdgeInsets.only(top: 10),
            child: dropdown,
          )),
        ],
      ),
    );
  }

  Widget buildImageContainer({
    required String title,
    required XFile? image,
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
              image: image != null
                  ? DecorationImage(
                image: FileImage(File(image.path)),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: image == null
                ? const Icon(Icons.add_photo_alternate_outlined,
                size: 40, color: Colors.grey)
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
