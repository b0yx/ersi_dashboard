import 'dart:ui';
import 'dart:io';

import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/modules/home/views/widget/custom_dropdown.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageForm extends StatelessWidget {
  final String formNAme;
  final XFile? firstImage;
  final XFile? secondImage;
  final VoidCallback onPickFirstImage;
  final VoidCallback onPickSecondImage;

  const CustomImageForm({
    super.key,
    required this.firstImage,
    required this.secondImage,
    required this.onPickFirstImage,
    required this.onPickSecondImage,
    required this.formNAme,
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
          CustomText(maxLine: 1,
            alignment: Alignment.center,
            color: ColorsApp.greencolorapp,
            text: formNAme,),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              buildImageContainer(
                title: 'إضافة صورة المخطط',
                image: firstImage,
                onTap: onPickFirstImage,
              ),
              buildImageContainer(
                title: 'إضافة صورة المنفذ',
                image: secondImage,
                onTap: onPickSecondImage,
              ),
            ],
          ),
          CustomDropdownField(title: 'نسبة المطابقة',
            items:const ['ممتاز ','جيد','سيئ'],
            selectedItem: 'ممتاز',
            onChanged: (String value) {  },),

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
                image: FileImage(
                  File(image.path),
                ),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: image == null
                ? const Icon(Icons.add_photo_alternate_outlined, size: 40, color: Colors.grey)
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
