import 'package:ersei/app/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/class/handlingdataview.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/functions/functioninput.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/create_project_controller.dart';
import '../widget/custometext.dart';
import '../widget/customiconbutton.dart';
import '../widget/customtextformfield.dart';
import '../widget/custom_dropdown.dart';
import '../widget/customelevetbutton.dart';

class CreateProjectView extends GetView<CreateProjectControllerImp> {
  const CreateProjectView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:GetBuilder<CreateProjectControllerImp>(
            builder: (controller) => controller.statuesRequest == StatusRequest.loading
            ? const Center(child: HandlingDataView(
            statusRequest: StatusRequest.loading, widget: Center()),
            ) : Form(
            key: controller.formstate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomIconButton(
                  icon: Icons.arrow_back_ios_new,
                  onPressed:  () => Get.back(),
                  color: Colors.grey,
                ),
                const SizedBox(height: 20),
                 Center(
                  child:CustomText(maxLine: 1,
                    text: '${controller.userName} مرحبا بعودتك ',
                    fontSize: 30,
                    alignment: Alignment.center,),

                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  hintText: 'اسم المشروع',
                  textAlign: TextAlign.right,
                  validator: (val) {
                    return validInput(val!, 7, 50, "samplename");
                  },
                  controller: controller.projectName,
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
                  validator: (val) {
                    return validInput(val!, 7, 50, "samplename");
                  },
                  controller: controller.projectReportOwner,
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
                  validator: (val) {
                    return validInput(val!, 8, 10, "phone");
                  },
                  controller: controller.phone,
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
                Obx(() =>  CustomDropdownField(
                  dropdownLabel: 'نوع المنشأة',
                  selectedDropdownItem: controller.selectedBuildingType.value,
                  dropdownItems: ['حكومية','خاصة'],
                  onDropdownChanged: (value) {
                    controller.updateBuildingType(value!);
                  },
                ),),
                const SizedBox(height: 15),
            Obx(() => CustomDropdownField(

                  dropdownLabel: 'الغرض من الفحص',
                  selectedDropdownItem: controller.selectedPurposeForInspection.value,
                  dropdownItems: ['فحص الصيانة الدورية','فحص السلامة'],
                  onDropdownChanged: (value) {
                    controller.updatePurposeForInspection(value!);
                  },
                ),),
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
                    onPressed:controller.createProject,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    ),
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
