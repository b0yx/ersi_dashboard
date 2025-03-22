
import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/modules/home/views/widget/customelevetbutton.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/electrical_inspection_controller.dart';
import '../widget/custom_checkbox.dart';
import '../widget/custom_dropdown.dart';
import '../widget/custom_image_with_muldropdownlist.dart';

class ElectricalInspectionView extends GetView<ElectricalInspectionControllerImp> {
  ElectricalInspectionView({super.key});



  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> receivedData = Get.arguments ?? {};

    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp ,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
            onPressed: () => Get.back(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.black54),
              onPressed: () => Get.offAllNamed(Routes.HOME),
            ),
          ],
          title:const CustomText(
            maxLine: 1,
            alignment: Alignment.center,
            text: 'الفحص المعماري ',
          )

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              const SizedBox(height: 20),
              //////البلاط الارضي فحص المواد
              Obx(() => CustomImageMulForm(
                formName: "فحص المواد - النموذج 1",
                sectionName: "البلاط الأرضي",
                firstImageLabel: "صورة المخطط",
                secondImageLabel: "صورة المنفذ",
                firstImagePath: controller.inspectionData['form1_مخطط'],
                secondImagePath: controller.inspectionData['form1_منفذ'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'form1', 'مخطط'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'form1', 'منفذ'),
                dropdowns: [
                  CustomDropdownField(
                    dropdownLabel: 'نوع البلاط',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem:
                    controller.inspectionData['form1_نوع البلاط'] ?? 'جيد',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue('form1', 'نوع البلاط', value);
                      }
                    },
                  ),
                ],
                checkboxes: [
                  CustomCheckboxField(
                    label: 'ميول',
                    isChecked:
                    controller.inspectionData['form1_ميول'] ?? false,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateValue('form1', 'ميول', value);
                      }
                    },
                  ),
                ],
              )),
              const SizedBox(height: 20),
              //////////فحص المواد البلاط الجدران
              Obx(() => CustomImageMulForm(
                formName: "فحص المواد ",
                sectionName: "البلاط للجدران",
                firstImageLabel: "صورة المخطط",
                secondImageLabel: "صورة المنفذ",
                firstImagePath: controller.inspectionData['form2_مخطط'],
                secondImagePath: controller.inspectionData['form2_منفذ'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'form2', 'مخطط'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'form2', 'منفذ'),
                dropdowns: [
                  CustomDropdownField(
                    dropdownLabel: 'نوع البلاط',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem:
                    controller.inspectionData['form2_نوع البلاط'] ?? 'جيد',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue('form2', 'نوع البلاط', value);
                      }
                    },
                  ),
                ],
                checkboxes: [
                  CustomCheckboxField(
                    label: 'ميول',
                    isChecked:
                    controller.inspectionData['form2_ميول'] ?? false,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateValue('form2', 'ميول', value);
                      }
                    },
                  ),
                  CustomCheckboxField(
                    label: 'خواء',
                    isChecked:
                    controller.inspectionData['form2_خواء'] ?? false,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateValue('form2', 'خواء', value);
                      }
                    },
                  ),
                  CustomCheckboxField(
                    label: 'ترويبة',
                    isChecked:
                    controller.inspectionData['form2_ترويبة'] ?? false,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateValue('form2', 'ترويبة', value);
                      }
                    },
                  ),
                ],
              )),
              Obx(() => CustomImageMulForm(
                formName: "فحص المواد ",
                sectionName: "البلاط للجدران",
                firstImageLabel: "صورة المخطط",
                secondImageLabel: "صورة المنفذ",
                firstImagePath: controller.inspectionData['form2_مخطط'],
                secondImagePath: controller.inspectionData['form2_منفذ'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'form3', 'مخطط'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'form3', 'منفذ'),
                dropdowns: [
                  CustomDropdownField(
                    dropdownLabel: 'نوع البلاط',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem:
                    controller.inspectionData['vvv_نوع البلاط'] ?? 'جيد',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue('vvv', 'نوع البلاط', value);
                      }
                    },
                  ),
                ],
                checkboxes: [
                  CustomCheckboxField(
                    label: 'ميول',
                    isChecked:
                    controller.inspectionData['vvv_ميول'] ?? false,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateValue('vvv', 'ميول', value);
                      }
                    },
                  ),
                  CustomCheckboxField(
                    label: 'خواء',
                    isChecked:
                    controller.inspectionData['vvv_خواء'] ?? false,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateValue('vvv', 'خواء', value);
                      }
                    },
                  ),
                  CustomCheckboxField(
                    label: 'ترويبة',
                    isChecked:
                    controller.inspectionData['vvv_ترويبة'] ?? false,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateValue('vvv', 'ترويبة', value);
                      }
                    },
                  ),
                ],
              )),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
          CustomElevatedButton(
            label: 'التالي',
            backgroundColor: Colors.green,
            textColor: Colors.white,
            onPressed: () {

              controller.submitForm();
              receivedData.addAll(controller.inspectionData);
              print('==== recive data ========${receivedData.toString()}',);
              print('==== recive data ========${controller.inspectionData}',);
            },

          )
      ),
    );
  }
}
