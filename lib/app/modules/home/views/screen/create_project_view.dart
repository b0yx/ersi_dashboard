import 'package:ersei/app/core/constant/colors.dart';

import 'package:ersei/app/core/constant/imagesassets.dart';


import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/create_project_controller.dart';
import '../widget/custometext.dart';
import '../widget/customtextformfield.dart';
import '../widget/custom_date_picker.dart';
import '../widget/custom_dropdown.dart';
import '../widget/customelevetbutton.dart';
import '../widget/custom_bottom_sheet.dart';
import '../widget/custom_header.dart';

class CreateProjectView extends GetView<CreateProjectController> {
  const CreateProjectView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeader(
                onBackPressed: () => Get.back(),
                logoPath: ImageAssets.applogo,
              ),
              const SizedBox(height: 20),
              const Center(
                child: CustomText(
                  text: 'إنشاء مشروع',
                  fontSize: 24,
                  maxLine: 1,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                hintText: 'اسم المشروع',
                textalign: TextAlign.right,
                controller: TextEditingController(),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                hintstyle: const TextStyle(color: Colors.grey),
                keyboardType:
                    TextInputType.text, // لتحديد لوحة المفاتيح المناسبة
                fillColor: Colors.white, // تحديد خلفية الحقل باللون الأبيض
                filled: true, // تأكيد أن الخلفية مليئة
                borders: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                hintText: 'اسم جهة استلام التقرير',
                textalign: TextAlign.right,
                controller: TextEditingController(),
                hintstyle: const TextStyle(color: Colors.grey),
                keyboardType: TextInputType.text,
                fillColor: Colors.white, // تحديد خلفية الحقل باللون الأبيض
                filled: true, // تأكيد أن الخلفية مليئة
                borders: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                hintText: 'رقم الهاتف',
                textalign: TextAlign.right,
                controller: TextEditingController(),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                hintstyle: const TextStyle(color: Colors.grey),
                keyboardType: TextInputType.phone,
                fillColor: Colors.white, // تحديد خلفية الحقل باللون الأبيض
                filled: true,
                borders: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              const SizedBox(height: 15),
              CustomDatePicker(
                selectedDate: controller.selectedDate.value,
                onDateChanged: controller.updateDate,
              ),
              const SizedBox(height: 15),
              CustomDropdownField(
                title: 'الغرض من الفحص',
                onTap: _showPurposeSelection,
              ),
              const SizedBox(height: 15),
              CustomDropdownField(
                title: 'نوع المنشأة',
                onTap: _showBuildingTypeSelection,
              ),
              const Spacer(),
              CustomElevatedButton(
                label: 'NEXT',
                backgroundColor: const Color(0xFF96E6B3),
                textColor: Colors.white,
                onPressed: () => Get.toNamed(Routes.INSPECTION_TYPES),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showPurposeSelection() {
    Get.bottomSheet(
      CustomBottomSheet(
        options: ['فحص سلامة المبنى', 'فحص الصيانة الدورية'],
        onSelect: (selected) {
          controller.updatePurpose(selected);
          Get.back();
        },
      ),
    );
  }

  void _showBuildingTypeSelection() {
    Get.bottomSheet(
      CustomBottomSheet(
        options: ['سكني', 'تجاري', 'صناعي'],
        onSelect: (selected) {
          controller.updateBuildingType(selected);
          Get.back();
        },
      ),
    );
  }
}
