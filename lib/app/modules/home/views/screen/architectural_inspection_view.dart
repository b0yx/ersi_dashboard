import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/modules/home/views/widget/customelevetbutton.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/architectural_inspection_controller.dart';
import '../../controllers/inspection_types_controller.dart';
import '../widget/custom_checkbox.dart';
import '../widget/custom_dropdown.dart';
import '../widget/custom_image_with_muldropdownlist.dart';
import '../widget/inputform_horizntal.dart';

class ArchitecturalInspectionView
    extends GetView<ArchitecturalInspectionControllerImp> {
  ArchitecturalInspectionView({super.key});
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
          text: 'الفحص المعماري ',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // نموذج فحص المخطط -
              Obx(() => CustomImageMulForm(
                formName: "مطابقة المخطط مع المنفذ 1",
                firstImageLabel: "صورة المخطط",
                secondImageLabel: "صورة المنفذ",
                firstImagePath:
                controller.inspectionData['Architectural.form1_مخطط'],
                secondImagePath:
                controller.inspectionData['Architectural.form1_منفذ'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'Architectural.form1', 'مخطط'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'Architectural.form1', 'منفذ'),
                dropdowns: [
                  CustomDropdownField(
                    dropdownLabel: 'نسبة التطابق',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form1_نسبة التطابق'] ??
                        'نسبة التطابق',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form1', 'نسبة التطابق', value);
                      }
                    },
                  ),
                ],
              )),
              const SizedBox(height: 20),
              //  نموذج فحص المواد - الجدران خارجي
              Obx(() => CustomImageMulForm(
                formName: "2- فحص المواد",
                sectionName: "الجدران خارجي",
                firstImageLabel: "صورة 1",
                secondImageLabel: "صورة 2",
                firstImagePath:
                controller.inspectionData['Architectural.form2_الجدران خارجي واحد'],
                secondImagePath:
                controller.inspectionData['Architectural.form2_الجدران خارجي اثنين'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'Architectural.form2', 'الجدران خارجي واحد'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'Architectural.form2', 'الجدران خارجي اثنين'),
                dropdowns: [
                  //نوع البلك
                  CustomDropdownField(
                    dropdownLabel: 'نوع البلك',
                    dropdownItems: ['طوب', 'بلك'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form2_نوع البلك'] ??
                        'النوع',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form2', 'نوع البلك', value);
                      }
                    },
                  ),
                  //مقاس البلك
                  CustomDropdownField(
                    dropdownLabel: 'مقاس البلك',
                    dropdownItems: ['20', '15'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.مقاس البلك'] ??
                        'المقاس',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form2', 'نوع البلك', value);
                      }
                    },
                  ),
                  //استقامة الجدران
                  CustomDropdownField(
                    dropdownLabel: 'إستقامة الجدران',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form2_إستقامة الجدران'] ??
                        'الاستقامة',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form2', 'إستقامة الجدران', value);
                      }
                    },
                  ),
                  //التعبئة
                  CustomDropdownField(
                    dropdownLabel: 'التعبئة',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form2_التعبئة'] ??
                        'التعبئة',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form2', 'التعبئة', value);
                      }
                    },
                  ),
                  //شقوق
                  CustomDropdownField(
                    dropdownLabel: 'شقوق',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form2_شقوق'] ??
                        'شقوق',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form2', 'شقوق', value);
                      }
                    },
                  ),

                ],
                // checkboxes: [
                //   CustomCheckboxField(
                //     label: 'ميول',
                //     isChecked:
                //     controller.inspectionData['form1_ميول'] ?? false,
                //     onChanged: (value) {
                //       if (value != null) {
                //         controller.updateValue('form1', 'ميول', value);
                //       }
                //     },
                //   ),
                //
                //
                //
                // ],
              )),
              const SizedBox(height: 20),
              //  نموذج فحص المواد - الجدران داخلي
              Obx(() => CustomImageMulForm(
                formName: "2- فحص المواد",
                sectionName: "الجدران داخلي",
                firstImageLabel: "صورة 1",
                secondImageLabel: "صورة 2",
                firstImagePath:
                controller.inspectionData['Architectural.form3_الجدران داخلي واحد'],
                secondImagePath:
                controller.inspectionData['Architectural.form3_الجدران داخلي اثنين'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'Architectural.form3', 'الجدران داخلي واحد'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'Architectural.form3', 'الجدران داخلي اثنين'),
                dropdowns: [
                  //نوع البلك
                  CustomDropdownField(
                    dropdownLabel: 'نوع البلك',
                    dropdownItems: ['طوب', 'بلك'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form3_نوع البلك'] ??
                        'النوع',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form3', 'نوع البلك', value);
                      }
                    },
                  ),
                  //مقاس البلك
                  CustomDropdownField(
                    dropdownLabel: 'مقاس البلك',
                    dropdownItems: ['20', '15'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form3_مقاس البلك'] ??
                        'المقاس',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form3', 'نوع البلك', value);
                      }
                    },
                  ),
                  //استقامة الجدران
                  CustomDropdownField(
                    dropdownLabel: 'إستقامة الجدران',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form3_إستقامة الجدران'] ??
                        'الاستقامة',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form3', 'إستقامة الجدران', value);
                      }
                    },
                  ),
                  //التعبئة
                  CustomDropdownField(
                    dropdownLabel: 'التعبئة',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form3_التعبئة'] ??
                        'التعبئة',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form3', 'التعبئة', value);
                      }
                    },
                  ),
                  //شقوق
                  CustomDropdownField(
                    dropdownLabel: 'شقوق',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form3_شقوق'] ??
                        'شقوق',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form3', 'شقوق', value);
                      }
                    },
                  ),

                ],
                // checkboxes: [
                //   CustomCheckboxField(
                //     label: 'ميول',
                //     isChecked:
                //     controller.inspectionData['form1_ميول'] ?? false,
                //     onChanged: (value) {
                //       if (value != null) {
                //         controller.updateValue('form1', 'ميول', value);
                //       }
                //     },
                //   ),
                //
                //
                //
                // ],
              )),
              const SizedBox(height: 20),
              // نموذج فحص المواد - البلاط للجدران
              Obx(() => CustomImageMulFormHorizontal(
                formName: "2- فحص المواد",
                sectionName: "بلاط الجدران",
                firstImageLabel: "صورة 1",
                secondImageLabel: "صورة 2",
                firstImagePath:
                controller.inspectionData['Architectural.form4_بلاط الجدران واحد'],
                secondImagePath:
                controller.inspectionData['Architectural.form4_بلاط الجدران اثنين'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'Architectural.form4', 'بلاط الجدران واحد'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'Architectural.form4', 'بلاط الجدران اثنين'),
                dropdowns: [
                  //نوع البلاط
                  CustomDropdownField(
                    dropdownLabel: 'نوع البلاط',
                    dropdownItems: ['اسباني', 'هندي'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form4_نوع البلاط'] ??
                        'النوع',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form4', 'نوع البلاط', value);
                      }
                    },
                  ),
                  //حالة البلاط
                  CustomDropdownField(
                    dropdownLabel: 'حالة البلاط',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form4_حالة البلاط'] ??
                        'الحالة',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form4', 'حالة البلاط', value);
                      }
                    },
                  ),
                ],
                checkboxes: [
                  //ميول
                  CustomCheckboxField(
                    label: 'ميول',
                    isChecked:
                    controller.inspectionData['Architectural.form4_ميول جدران'] ?? false,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateValue('Architectural.form4', 'ميول جدران', value);
                      }
                    },
                  ),
                  //خواء
                  CustomCheckboxField(
                    label: 'خواء',
                    isChecked:
                    controller.inspectionData['Architectural.form4_خواء جدران'] ?? false,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateValue('Architectural.form4', 'خواء جدران', value);
                      }
                    },
                  ),
                  //ترويبة
                  CustomCheckboxField(
                    label: 'ترويبة',
                    isChecked:
                    controller.inspectionData['Architectural.form4_ترويبة جدران'] ?? false,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateValue('Architectural.form4', 'ترويبة جدران', value);
                      }
                    },
                  ),
                ],
              )),
              const SizedBox(height: 20),
              // نموذج فحص المواد - البلاط الارضي
              Obx(() => CustomImageMulFormHorizontal(
                formName: "2- فحص المواد",
                sectionName: "بلاط أرضي",
                firstImageLabel: "صورة 1",
                secondImageLabel: "صورة 2",
                firstImagePath:
                controller.inspectionData['Architectural.form5_بلاط ارضي صورة واحد'],
                secondImagePath:
                controller.inspectionData['Architectural.form5_بلاط ارضي صورة اثنين'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'Architectural.form5', 'بلاط ارضي صورة واحد'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'Architectural.form5', 'بلاط ارضي صورة اثنين'),
                dropdowns: [
                  //نوع البلاط
                  CustomDropdownField(
                    dropdownLabel: 'نوع البلاط',
                    dropdownItems: ['اسباني', 'هندي'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form5_نوع البلاط'] ??
                        'النوع',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form5', 'نوع البلاط', value);
                      }
                    },
                  ),
                  //حالة البلاط
                  CustomDropdownField(
                    dropdownLabel: 'حالة البلاط',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form5_حالة البلاط'] ??
                        'الحالة',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form5', 'حالة البلاط', value);
                      }
                    },
                  ),
                ],
                checkboxes: [
                  //ميول
                  CustomCheckboxField(
                    label: 'ميول',
                    isChecked:
                    controller.inspectionData['Architectural.form5_ميول جدران'] ?? false,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateValue('Architectural.form5', 'ميول جدران', value);
                      }
                    },
                  ),
                  //خواء
                  CustomCheckboxField(
                    label: 'خواء',
                    isChecked:
                    controller.inspectionData['Architectural.form5_خواء جدران'] ?? false,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateValue('Architectural.form5', 'خواء جدران', value);
                      }
                    },
                  ),
                  //ترويبة
                  CustomCheckboxField(
                    label: 'ترويبة',
                    isChecked:
                    controller.inspectionData['Architectural.form5_ترويبة جدران'] ?? false,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateValue('Architectural.form5', 'ترويبة جدران', value);
                      }
                    },
                  ),
                ],
              )),
              const SizedBox(height: 20),
              //الديكور للسقوف
              Obx(() => CustomImageMulForm(
                formName: "2- فحص المواد",
                sectionName: "ديكور سقف",
                firstImageLabel: "صورة 1",
                secondImageLabel: "صورة 2",
                firstImagePath:
                controller.inspectionData['Architectural.form6_ديكور سقف صورة واحد'],
                secondImagePath:
                controller.inspectionData['Architectural.form6_ديكور سقف صورة اثنين'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'Architectural.form6', 'ديكور سقف صورة واحد'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'Architectural.form6', 'ديكور سقف صورة اثنين'),
                dropdowns: [
                  //نوع الديكور
                  CustomDropdownField(
                    dropdownLabel: 'نوع الديكور',
                    dropdownItems: ['بلاستيك', 'جبس'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form6_نوع الديكور'] ??
                        'النوع',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form6', 'نوع الديكور', value);
                      }
                    },
                  ),
                  //جودة العمل
                  CustomDropdownField(
                    dropdownLabel: 'جودة العمل',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form6_جودة العمل'] ??
                        'الحالة',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form6', 'جودة العمل', value);
                      }
                    },
                  ),
                ],
              )),
              const SizedBox(height: 20),
              //الديكور للجدران
              Obx(() => CustomImageMulForm(
                formName: "2- فحص المواد",
                sectionName: "ديكور جدار",
                firstImageLabel: "صورة 1",
                secondImageLabel: "صورة 2",
                firstImagePath:
                controller.inspectionData['Architectural.form7_ديكور جدار صورة واحد'],
                secondImagePath:
                controller.inspectionData['Architectural.form7_ديكور جدار صورة اثنين'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'Architectural.form7', 'ديكور جدار صورة واحد'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'Architectural.form7', 'ديكور جدار صورة اثنين'),
                dropdowns: [
                  //نوع الديكور
                  CustomDropdownField(
                    dropdownLabel: 'نوع الديكور',
                    dropdownItems: ['بلاستيك', 'جبس'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form7_نوع الديكور'] ??
                        'النوع',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form7', 'نوع الديكور', value);
                      }
                    },
                  ),
                  //جودة العمل
                  CustomDropdownField(
                    dropdownLabel: 'جودة العمل',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form7_جودة العمل'] ??
                        'الحالة',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form7', 'جودة العمل', value);
                      }
                    },
                  ),
                ],
              )),
              const SizedBox(height: 20),
              //اللياسة
              Obx(() => CustomImageMulForm(
                formName: "2- فحص المواد",
                sectionName: "اللياسة",
                firstImageLabel: "صورة 1",
                secondImageLabel: "صورة 2",
                firstImagePath:
                controller.inspectionData['Architectural.form8_اللياسة صورة واحد'],
                secondImagePath:
                controller.inspectionData['Architectural.form8_اللياسة صورة اثنين'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'Architectural.form8', 'اللياسة صورة واحد'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'Architectural.form8', 'اللياسة صورة اثنين'),
                dropdowns: [
                  //نوع اللياسة
                  //جودة العمل
                  CustomDropdownField(
                    dropdownLabel: 'جودة العمل',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form8_جودة العمل'] ??
                        'الحالة',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form8', 'جودة العمل', value);
                      }
                    },
                  ),
                ],
              )),
              const SizedBox(height: 20),
              //الابواب خارجي
              Obx(() => CustomImageMulForm(
                formName: "2- فحص المواد",
                sectionName: "الابواب خارجي",
                firstImageLabel: "صورة 1",
                secondImageLabel: "صورة 2",
                firstImagePath:
                controller.inspectionData['Architectural.form9_الابواب الخارجي صورة واحد'],
                secondImagePath:
                controller.inspectionData['Architectural.form9_الابواب الخارجي صورة اثنين'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'Architectural.form9', 'الابواب الخارجي صورة واحد'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'Architectural.form9', 'الابواب الخارجي صورة اثنين'),
                dropdowns: [
                  //نوع الابواب
                  CustomDropdownField(
                    dropdownLabel: 'نوع الابواب',
                    dropdownItems: ['خشب', 'حديد'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form9_نوع الابواب'] ??
                        'النوع',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form9', 'نوع الابواب', value);
                      }
                    },
                  ),
                  //جودة العمل
                  CustomDropdownField(
                    dropdownLabel: 'جودة العمل',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form9_جودة العمل'] ??
                        'الحالة',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form9', 'جودة العمل', value);
                      }
                    },
                  ),
                ],
              )),
              const SizedBox(height: 20),
              //الابواب داخلي
              Obx(() => CustomImageMulForm(
                formName: "2- فحص المواد",
                sectionName: "الابواب داخلي",
                firstImageLabel: "صورة 1",
                secondImageLabel: "صورة 2",
                firstImagePath:
                controller.inspectionData['Architectural.form10_الابواب داخلي صورة واحد'],
                secondImagePath:
                controller.inspectionData['Architectural.form10_الابواب داخلي صورة اثنين'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'Architectural.form10', 'الابواب داخلي صورة واحد'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'Architectural.form10', 'الابواب داخلي صورة اثنين'),
                dropdowns: [
                  //نوع الابواب
                  CustomDropdownField(
                    dropdownLabel: 'نوع الابواب',
                    dropdownItems: ['خشب', 'حديد'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form10_نوع الابواب'] ??
                        'النوع',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form10', 'نوع الابواب', value);
                      }
                    },
                  ),
                  //جودة العمل
                  CustomDropdownField(
                    dropdownLabel: 'جودة العمل',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form10_جودة العمل'] ??
                        'الحالة',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form10', 'جودة العمل', value);
                      }
                    },
                  ),
                ],
              )),
              const SizedBox(height: 20),
              //الشبابيك
              Obx(() => CustomImageMulForm(
                formName: "2- فحص المواد",
                sectionName: "الشبابيك",
                firstImageLabel: "صورة 1",
                secondImageLabel: "صورة 2",
                firstImagePath:
                controller.inspectionData['Architectural.form11_الشبابيك صورة واحد'],
                secondImagePath:
                controller.inspectionData['Architectural.form11_الشبابيك صورة اثنين'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'Architectural.form11', 'الشبابيك صورة واحد'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'Architectural.form11', 'الشبابيك صورة اثنين'),
                dropdowns: [
                  //نوع الشبابيك
                  CustomDropdownField(
                    dropdownLabel: 'نوع الشبابيك',
                    dropdownItems: ['خشب', 'المومنيوم'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form11_نوع الشبابيك'] ??
                        'النوع',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form11', 'نوع الشبابيك', value);
                      }
                    },
                  ),
                  //جودة العمل
                  CustomDropdownField(
                    dropdownLabel: 'جودة العمل',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Architectural.form11_جودة العمل'] ??
                        'الحالة',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Architectural.form11', 'جودة العمل', value);
                      }
                    },
                  ),
                ],
              )),

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
            // تنفيذ العمليات اللازمة في الصفحة الحالية وحفظ بيانات النموذج
            controller.submitForm();
            // بعد الانتهاء من تعبئة الصفحة الحالية، يتم الانتقال إلى الصفحة التالية من القائمة المختارة
            // ستستدعي دالة navigateToNextSelectedPage() الموجودة في InspectionTypesController
            // يمكن استدعاؤها من خلال Get.find<InspectionTypesController>()
            final inspectionTypesController = Get.find<InspectionTypesController>();
            inspectionTypesController.navigateToNextSelectedPage();


            // استلام المعاملات المرسلة من الشاشة السابقة
            // إذا لم تكن المعاملات موجودة، يمكن إنشاء قائمة فارغة



            // التحقق من وجود صفحات متبقية للتنقل إليها

          },
        ),
      ),
    );
  }
}
