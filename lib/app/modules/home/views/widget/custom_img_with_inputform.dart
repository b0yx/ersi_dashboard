import 'dart:io';
import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/modules/home/views/widget/custom_dropdown.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:flutter/material.dart';
import 'custom_checkbox.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class CustomImageMulFormWithInputForm extends StatelessWidget {
  final String formName;
  final String? sectionName;
  final String? firstImageLabel;
  final String? secondImageLabel;
  final String? firstImagePath;
  final String? secondImagePath;
  final VoidCallback onPickFirstImage;
  final VoidCallback onPickSecondImage;
  final List<CustomDropdownField> dropdowns;
  final List<CustomCheckboxField> checkboxes;
  final TextEditingController inputController;
  // المتغير التفاعلي لحقل الإخراج
  final RxString outputRx;
  final String inputKey;
  final String outputKey;
  final void Function(String) onInputChanged;

  const CustomImageMulFormWithInputForm({
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
    required this.inputController,
    required this.outputRx,
    required this.inputKey,
    required this.outputKey,
    required this.onInputChanged,
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
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: inputController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [LengthLimitingTextInputFormatter(2)],
                  decoration: InputDecoration(
                    labelText: 'أدخل القيمة',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: onInputChanged,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Obx(() => TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'النتيجة',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: TextEditingController(text: outputRx.value),
                )),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...dropdowns.map((dropdown) => Padding(
            padding: const EdgeInsets.only(top: 10),
            child: dropdown,
          )),
          const SizedBox(height: 20),
          ...checkboxes.map((checkbox) => Padding(
            padding: const EdgeInsets.only(top: 10),
            child: checkbox,
          )),
        ],
      ),
    );
  }
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
