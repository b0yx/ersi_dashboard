import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/modules/home/views/widget/customelevetbutton.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/inspection_types_controller.dart';
import '../../controllers/structural_inspection_controller.dart';
import '../widget/custom_checkbox.dart';
import '../widget/custom_dropdown.dart';
import '../widget/custom_image_with_muldropdownlist.dart';
import '../widget/custom_img_with_inputform.dart';

class StructuralInspectionView extends GetView<StructuralInspectionControllerImp> {
  StructuralInspectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> remainingPages = Get.arguments?['remainingPages'] ?? [];
    final String inspectionCategory = Get.arguments?['inspectionCategory'] ?? "غير محدد";
    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp,
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
          title: const CustomText(
            maxLine: 1,
            alignment: Alignment.center,
            text: 'الفحص الانشائي ',
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // نموذج form1 لحقل "قراءة المطرقة / مقاومة الخرسانة"
              // CustomImageMulFormWithInputForm(
              //   formName: '  الخرسانة ',
              //   sectionName: "القياسات",
              //   inputController: controller.hammerInputControllers.putIfAbsent("form2", () => TextEditingController()),
              //   outputRx: controller.hammerOutputRxMap.putIfAbsent("form2", () => ''.obs),
              //   inputKey: "قراءة المطرقة",
              //   outputKey: "مقاومة الخرسانة",
              //   onInputChanged: (value) {
              //     controller.updateInputValue("form2", "قراءة المطرقة", value);
              //   },
              //   firstImageLabel: "صورة 1",
              //   secondImageLabel: "صورة 2",
              //   firstImagePath:controller.inspectionData['form1_مخطط'],
              //   secondImagePath: controller.inspectionData['form2_منفذ'],
              //   onPickFirstImage: () =>
              //       controller.pickImage(context, 'form1', 'منفذ'),
              //   onPickSecondImage: () =>
              //       controller.pickImage(context, 'form1', 'منفذ'),
              //   dropdowns: [
              //     CustomDropdownField(
              //       dropdownLabel: 'نوع البلاط',
              //       dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
              //       selectedDropdownItem: controller
              //           .inspectionData['form1_نوع البلاط'] ??
              //           'جيد',
              //       onDropdownChanged: (value) {
              //         if (value != null) {
              //           controller.updateValue(
              //               'form1', 'نوع البلاط', value);
              //         }
              //       },
              //     ),
              //   ],
              //   checkboxes: [
              //     CustomCheckboxField(
              //       label: 'ميول',
              //       isChecked:
              //       controller.inspectionData['form1_ميول'] ?? false,
              //       onChanged: (value) {
              //         if (value != null) {
              //           controller.updateValue('form1', 'ميول', value);
              //         }
              //       },
              //     ),
              //   ],
              // ),
              const SizedBox(height: 20),
              // نموذج form2 لحقل "قراءة المطرقة / مقاومة الخرسانة"
              Obx(() =>CustomImageMulFormWithInputForm(
                formName: '  الخرسانة ',
                sectionName: "القياسات",
                firstImageLabel: "صورة 1",
                secondImageLabel: "صورة 2",
                firstImagePath:controller.inspectionData['form1_مخطط'],
                secondImagePath: controller.inspectionData['form2_منفذ'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'form1', 'مخطط'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'form2', 'منفذ'),
                inputController: controller.hammerInputControllers.putIfAbsent("form2", () => TextEditingController()),
                outputRx: controller.hammerOutputRxMap.putIfAbsent("form2", () => ''.obs),
                inputKey: "قراءة المطرقة",
                outputKey: "مقاومة الخرسانة",
                onInputChanged: (value) {
                  controller.updateInputValue("form2", "قراءة المطرقة", value);
                },
                dropdowns: [
                  CustomDropdownField(
                    dropdownLabel: 'نوع البلاط',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['form1_نوع البلاط'] ??
                        'جيد',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'form1', 'نوع البلاط', value);
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
              // CustomImageMulFormWithInputForm(
              //   formName: 'قراءة المطرقة / مقاومة الخرسانة - النموذج 2',
              //   sectionName: "القياسات",
              //   firstImageLabel: "",
              //   secondImageLabel: "",
              //   firstImagePath: null,
              //   secondImagePath: null,
              //   onPickFirstImage: () {},
              //   onPickSecondImage: () {},
              //   inputController: controller.hammerInputControllers.putIfAbsent("form3", () => TextEditingController()),
              //   outputRx: controller.hammerOutputRxMap.putIfAbsent("form3", () => ''.obs),
              //   inputKey: "قراءة المطرقة",
              //   outputKey: "مقاومة الخرسانة",
              //   onInputChanged: (value) {
              //     controller.updateInputValue("form3", "قراءة المطرقة", value);
              //   },
              // ),
              // const SizedBox(height: 20),
              // // مثال لحقل آخر لنفس النموذج form1 (مثلاً "مقاومة الأعمدة")
              // Obx(() => CustomImageMulForm(
              //   formName: "فحص المواد - النموذج 1",
              //   sectionName: "البلاط الأرضي",
              //   firstImageLabel: "صورة المخطط",
              //   secondImageLabel: "صورة المنفذ",
              //   firstImagePath:
              //   controller.inspectionData['form1_مخطط'],
              //   secondImagePath:
              //   controller.inspectionData['form1_منفذ'],
              //   onPickFirstImage: () =>
              //       controller.pickImage(context, 'form1', 'مخطط'),
              //   onPickSecondImage: () =>
              //       controller.pickImage(context, 'form1', 'منفذ'),
              //
              // )),
              // const SizedBox(height: 20),
              // يمكن إضافة المزيد من النماذج باستخدام مفاتيح فريدة لكل منها
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomElevatedButton(
            label: 'التالي',
            backgroundColor: Colors.green,
            textColor: Colors.white,
            onPressed: () {
              controller.submitForm();
              final inspectionTypesController = Get.find<InspectionTypesController>();
              inspectionTypesController.navigateToNextSelectedPage();
              Get.toNamed(
                remainingPages.removeAt(0),
                arguments: {
                  "remainingPages": remainingPages,
                  "inspectionCategory": inspectionCategory,
                },
              );
            },
          )),
    );
  }
}
