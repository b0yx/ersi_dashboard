import 'package:ersei/app/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/create_project_controller.dart';
import '../widget/custometext.dart';
import '../widget/customiconbutton.dart';
import '../widget/customtextformfield.dart';
import '../widget/custom_dropdown.dart';
import '../widget/customelevetbutton.dart';

class CreateProjectView extends GetView<CreateProjectController> {
  const CreateProjectView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp,
      body: SafeArea(
        child: ListView(
          children:[ Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomIconButton(
                  icon: Icons.arrow_back_ios_new,
                  onPressed:  () => Get.back(),
                  color: Colors.grey,
                ),
                const SizedBox(height: 20),
                const Center(
                  child: CustomText(
                    text: 'إنشاء مشروع',
                    fontSize: 24,
                    maxLine: 1,
                    fontWeight: FontWeight.bold,
                    alignment: Alignment.center,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  hintText: 'اسم المشروع',
                  textAlign: TextAlign.right,
                  controller: TextEditingController(),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  hintStyle: const TextStyle(color: Colors.grey),
                  keyboardType:
                      TextInputType.text, // لتحديد لوحة المفاتيح المناسبة
                  fillColor: Colors.white, // تحديد خلفية الحقل باللون الأبيض
                  filled: true,
                  // تأكيد أن الخلفية مليئة
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  hintText: 'اسم جهة استلام التقرير',
                  textAlign: TextAlign.right,
                  controller: TextEditingController(),
                  hintStyle: const TextStyle(color: Colors.grey),
                  keyboardType: TextInputType.text,
                  fillColor: Colors.white, // تحديد خلفية الحقل باللون الأبيض
                  filled: true, // تأكيد أن الخلفية مليئة
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  hintText: 'رقم الهاتف',
                  textAlign: TextAlign.right,
                  controller: TextEditingController(),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  hintStyle: const TextStyle(color: Colors.grey),
                  keyboardType: TextInputType.phone,
                  fillColor: Colors.white, // تحديد خلفية الحقل باللون الأبيض
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                const SizedBox(height: 15),
                // CustomDatePicker(
                //   selectedDate: controller.selectedDate.value,
                //   onDateChanged: controller.updateDate,
                // ),
                const SizedBox(height: 15),
                CustomDropdownField(

                  dropdownLabel: 'نوع المنشأة',
                  selectedDropdownItem: 'خاصة',
                  dropdownItems: ['حكومية','خاصة'],
                  onDropdownChanged: (value) {
                  },
                ),
                const SizedBox(height: 15),
                CustomDropdownField(

                  dropdownLabel: 'الغرض من الفحص',
                  selectedDropdownItem: 'فحص الصيانة الدورية',
                  dropdownItems: ['فحص الصيانة الدورية','فحص السلامة'],
                  onDropdownChanged: (value) {
                  },
                ),
                // CustomElevatedButton(
                //   label: 'NEXT',
                //   backgroundColor: const Color(0xFF96E6B3),
                //   textColor: Colors.white,
                //   onPressed: () => Get.toNamed(Routes.INSPECTION_TYPES),
                // ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    label: 'التالي',
                    backgroundColor: ColorsApp.greencolorapp,
                    textColor: Colors.white,
                    onPressed:() => Routes.INSPECTION_TYPES,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

        ]),
      ),
    );
  }
  //
  // void _showPurposeSelection() {
  //   Get.bottomSheet(
  //     CustomBottomSheet(
  //       options: ['فحص سلامة المبنى', 'فحص الصيانة الدورية'],
  //       onSelect: (selected) {
  //         controller.updatePurpose(selected);
  //         Get.back();
  //       },
  //     ),
  //   );
  // }
  //
  // void _showBuildingTypeSelection() {
  //   Get.bottomSheet(
  //     CustomBottomSheet(
  //       options: ['سكني', 'تجاري', 'صناعي'],
  //       onSelect: (selected) {
  //         controller.updateBuildingType(selected);
  //         Get.back();
  //       },
  //     ),
  //   );
  // }

}
