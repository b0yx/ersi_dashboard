
import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/modules/home/views/widget/customelevetbutton.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/mechanical_inspection_controller.dart';
import '../widget/custom_dropdown.dart';
import '../widget/custom_image_with_muldropdownlist.dart';

class MechanicalInspectionView extends GetView<MechanicalInspectionControllerImp> {
  MechanicalInspectionView({super.key});



  @override
  Widget build(BuildContext context) {

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
            text: 'الفحص الميكانيكي(السباكة) ',
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // مطابقة المخطط مع المنفذ
                Obx(() => CustomImageMulForm(
                  formName: "مطابقة المخطط مع المنفذ 1",
                  firstImageLabel: "صورة المخطط",
                  secondImageLabel: "صورة المنفذ",
                  firstImagePath:
                  controller.inspectionData['Mechanical.form1_مخطط'],
                  secondImagePath:
                  controller.inspectionData['Mechanical.form1_منفذ'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Mechanical.form1', 'مخطط'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Mechanical.form1', 'منفذ'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نسبة التطابق',
                      dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                      selectedDropdownItem: controller
                          .inspectionData['Mechanical.form1_نسبة التطابق'] ??
                          'نسبة التطابق',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Mechanical.form1', 'نسبة التطابق', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),
                // اختبار الضغط للتمديدات الداخلية
                Obx(() => CustomImageMulForm(
                  formName: "اختبار الضغط للتمديدات الداخلية",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Mechanical.form2_اختبار الضغط صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Mechanical.form2_اختبار الضغط صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Mechanical.form2', 'اختبار الضغط صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Mechanical.form2', 'اختبار الضغط صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'اختبار الضغط',
                      dropdownItems: ['سيئ', 'ممتاز'],
                      selectedDropdownItem: controller
                          .inspectionData['Mechanical.form2_اختبار الضغط'] ??
                          'الحالة',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Mechanical.form2', 'اختبار الضغط', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),
                //شبكة الصرف الحي
                Obx(() => CustomImageMulForm(
                  formName: "شبكة الصرف الصحي",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Mechanical.شبكة الصرف الصحي صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Mechanical.شبكة الصرف الصحي صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Mechanical.form3', 'شبكة الصرف الصحي صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Mechanical.form3', 'شبكة الصرف الصحي صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نوعها',
                      dropdownItems: ['خاصة', 'حكومية'],
                      selectedDropdownItem: controller
                          .inspectionData['Mechanical.form3_نوعها'] ??
                          'نوعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Mechanical.form3', 'نوعها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'الحالة',
                      dropdownItems: ['غير موجوده', 'موجوده'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form3_الحالة'] ??
                          'الحالة',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form3', 'الحالة', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),
                //مواصير التهوي
                Obx(() => CustomImageMulForm(
                  formName: "مواصير التهوية",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Mechanical.form4_مواصير التهوية صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Mechanical.form4_مواصير التهوية صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Mechanical.form4', 'مواصير التهوية صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Mechanical.form4', 'مواصير التهوية صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'الحالة',
                      dropdownItems: ['موجوده', 'غير موجوده'],
                      selectedDropdownItem: controller
                          .inspectionData['Mechanical.form4_الحالة'] ??
                          'الحالة',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Mechanical.form4', 'الحالة', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),

                //شبكة تصريف مياة الامطار
                Obx(() => CustomImageMulForm(
                  formName: "شبكة تصريف مياة الامطار",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Mechanical.form5_شبكة تصريف مياة الامطار صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Mechanical.form5_شبكة تصريف مياة الامطار صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Mechanical.form5', 'شبكة تصريف مياة الامطار صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Mechanical.form5', 'شبكة تصريف مياة الامطار صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'الحالة',
                      dropdownItems: ['موجودة', 'غير موجودة'],
                      selectedDropdownItem: controller
                          .inspectionData['Mechanical.form5_الحالة'] ??
                          'الحالة',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Mechanical.form5', 'الحالة', value);
                        }
                      },
                    ),

                  ],
                )),
                const SizedBox(height: 20),

                //المواد الصحية
                Obx(() => CustomImageMulForm(
                  formName: "نوعية وجودة المواد الصحية",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Mechanical.form6_المواد الصحية صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Mechanical.form6_المواد الصحية صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Mechanical.form6', 'المواد الصحية صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Mechanical.form6', 'المواد الصحية صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نوعها',
                      dropdownItems: ['ايطالي', 'اخرى'],
                      selectedDropdownItem: controller
                          .inspectionData['Mechanical.form6_نوعها'] ??
                          'نوعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Mechanical.form6', 'نوعها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'جودتها',
                      dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form6_حالتها'] ??
                          'حالتها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form6', 'حالتها', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),

                //خزانات المياة
                //خزانات السطح
                Obx(() => CustomImageMulForm(
                  formName: "خزانات المياة",
                  sectionName: 'خزانات السطح',
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Mechanical.form7_خزانات السطح صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Mechanical.form7_خزانات السطح صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Mechanical.form7', 'خزانات السطح صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Mechanical.form7', 'خزانات السطح صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نوعها',
                      dropdownItems: ['بلاستيك', 'حديد'],
                      selectedDropdownItem: controller
                          .inspectionData['Mechanical.form7_نوعها'] ??
                          'نوعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Mechanical.form7', 'نوعها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'حالتها',
                      dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                      selectedDropdownItem: controller
                          .inspectionData['Mechanical.form7_حالتها'] ??
                          'حالتها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Mechanical.form7', 'حالتها', value);
                        }
                      },
                    ),],
                )),
                const SizedBox(height: 20),

                //خزانات ارضية
                Obx(() => CustomImageMulForm(
                  formName: "خزانات المياة",
                  sectionName: 'خزانات ارضية',
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Mechanical.form8_خزانات ارضية صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Mechanical.form8_خزانات ارضية صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Mechanical.form8', 'خزانات ارضية صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Mechanical.form8', 'خزانات ارضية صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نوعها',
                      dropdownItems: ['حديد', 'بلاستيك','اسمنتي'],
                      selectedDropdownItem: controller
                          .inspectionData['Mechanical.form8_نوعها'] ??
                          'نوعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Mechanical.form8', 'نوعها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'حالتها',
                      dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                      selectedDropdownItem: controller
                          .inspectionData['Mechanical.form8_حالتها'] ??
                          'حالتها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Mechanical.form8', 'حالتها', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),
              ]
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

            },
          )),
    );
  }
}
