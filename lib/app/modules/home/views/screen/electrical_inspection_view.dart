
import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/modules/home/views/widget/customelevetbutton.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/electrical_inspection_controller.dart';
import '../widget/custom_dropdown.dart';
import '../widget/custom_image_with_muldropdownlist.dart';


class ElectricalInspectionView extends GetView<ElectricalInspectionControllerImp> {
  ElectricalInspectionView({super.key});



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
            text: 'الفحص الكهربائي ',
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
                  controller.inspectionData['Electrical.form1_مخطط'],
                  secondImagePath:
                  controller.inspectionData['Electrical.form1_منفذ'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Electrical.form1', 'مخطط'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Electrical.form1', 'منفذ'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نسبة التطابق',
                      dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form1_نسبة التطابق'] ??
                          'نسبة التطابق',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form1', 'نسبة التطابق', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),
                // النظام المستخدم
                Obx(() => CustomImageMulForm(
                  formName: "النظام المستخدم",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Electrical.form2_النظام المستخدم صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Electrical.form2_النظام المستخدم صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Electrical.form2', 'النظام المستخدم صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Electrical.form2', 'النظام المستخدم صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'النظام المستخدم',
                      dropdownItems: ['طاقة متجددة', 'كهرباء'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form2_النظام المستخدم'] ??
                          'النظام المستخدم',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form2', 'النظام المستخدم', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),
                //الاضاءة
                Obx(() => CustomImageMulForm(
                  formName: "الاضاءة",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Electrical.form3_الاضاءة صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Electrical.form3_الاضاءة صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Electrical.form3', 'الاضاءة صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Electrical.form3', 'الاضاءة صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نوعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form3_نوعها'] ??
                          'نوعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form3', 'نوعها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'حالتها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form3_حالتها'] ??
                          'حالتها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form3', 'حالتها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'توزيعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form3_توزيعها'] ??
                          'توزيعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form3', 'توزيعها', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),
                //المآخذ
                Obx(() => CustomImageMulForm(
                  formName: "المآخذ",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Electrical.form4_المآخذ صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Electrical.form4_المآخذ صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Electrical.form4', 'المآخذ صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Electrical.form4', 'المآخذ صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نوعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form4_نوعها'] ??
                          'نوعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form4', 'نوعها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'حالتها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form4_حالتها'] ??
                          'حالتها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form4', 'حالتها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'توزيعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form4_توزيعها'] ??
                          'توزيعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form4', 'توزيعها', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),

                //المفاتيح
                Obx(() => CustomImageMulForm(
                  formName: "المفاتيح",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Electrical.form5_المفاتيح صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Electrical.form5_المفاتيح صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Electrical.form5', 'المفاتيح صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Electrical.form5', 'المفاتيح صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نوعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form5_نوعها'] ??
                          'نوعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form5', 'نوعها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'حالتها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form5_حالتها'] ??
                          'حالتها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form5', 'حالتها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'توزيعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form5_توزيعها'] ??
                          'توزيعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form5', 'توزيعها', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),

                //اللوحات الرئيسية
                Obx(() => CustomImageMulForm(
                  formName: "اللوحات الرئيسية",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Electrical.form6_اللوحات الرئيسية صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Electrical.form6_اللوحات الرئيسية صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Electrical.form6', 'اللوحات الرئيسية صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Electrical.form6', 'اللوحات الرئيسية صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نوعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form6_نوعها'] ??
                          'نوعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form6', 'نوعها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'حالتها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
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
                    CustomDropdownField(
                      dropdownLabel: 'توزيعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form6_توزيعها'] ??
                          'توزيعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form6', 'توزيعها', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),

                //اللوحات الفرعية
                Obx(() => CustomImageMulForm(
                  formName: "اللوحات الفرعية",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Electrical.form7_اللوحات الفرعية صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Electrical.form7_اللوحات الفرعية صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Electrical.form7', 'اللوحات الفرعية صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Electrical.form7', 'اللوحات الفرعية صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نوعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form7_نوعها'] ??
                          'نوعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form7', 'نوعها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'حالتها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form7_حالتها'] ??
                          'حالتها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form7', 'حالتها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'توزيعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form7_توزيعها'] ??
                          'توزيعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form7', 'توزيعها', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),

                //القواطع
                Obx(() => CustomImageMulForm(
                  formName: "القواطع",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Electrical.form8_القواطع صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Electrical.form8_القواطع صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Electrical.form8', 'القواطع صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Electrical.form8', 'القواطع صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نوعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form8_نوعها'] ??
                          'نوعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form8', 'نوعها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'حالتها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form8_حالتها'] ??
                          'حالتها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form8', 'حالتها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'توزيعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form8_توزيعها'] ??
                          'توزيعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form8', 'توزيعها', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),

                //الكيبلات الرئيسية
                Obx(() => CustomImageMulForm(
                  formName: "الكيبلات الرئيسية",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Electrical.form9_الكيبلات الرئيسية صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Electrical.form9_الكيبلات الرئيسية صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Electrical.form9', 'الكيبلات الرئيسية صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Electrical.form9', 'الكيبلات الرئيسية صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نوعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form9_نوعها'] ??
                          'نوعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form9', 'نوعها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'حالتها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form9_حالتها'] ??
                          'حالتها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form9', 'حالتها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'توزيعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form9_توزيعها'] ?? 'توزيعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form9', 'توزيعها', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),

                //الاسلاك
                Obx(() => CustomImageMulForm(
                  formName: "الاسلاك",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Electrical.form10_الاسلاك صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Electrical.form10_الاسلاك صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Electrical.form10', 'الاسلاك صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Electrical.form10', 'الاسلاك صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'نوعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form10_نوعها'] ??
                          'نوعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form10', 'نوعها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'حالتها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form10_حالتها'] ??
                          'حالتها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form10', 'حالتها', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'توزيعها',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form10_توزيعها'] ??
                          'توزيعها',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form10', 'توزيعها', value);
                        }
                      },
                    ),
                  ],
                )),
                const SizedBox(height: 20),

                //نظام التأريض
                Obx(() => CustomImageMulForm(
                  formName: "نظام التأريض",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Electrical.form11_نظام التأريض صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Electrical.form11_نظام التأريض صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Electrical.form11', 'نظام التأريض صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Electrical.form11', 'نظام التأريض صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'الاحتياج',
                      dropdownItems: ['كافي', 'غير كافي'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form11_الاحتياج'] ??
                          'الاحتياج',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form11', 'الاحتياج', value);
                        }
                      },
                    ),

                  ],
                )),
                const SizedBox(height: 20),

                //نظام السخانات
                Obx(() => CustomImageMulForm(
                  formName: "نظام السخانات",
                  firstImageLabel: "صورة 1",
                  secondImageLabel: "صورة 2",
                  firstImagePath:
                  controller.inspectionData['Electrical.form12_نظام السخانات صورة واحد'],
                  secondImagePath:
                  controller.inspectionData['Electrical.form12_نظام السخانات صورة اثنين'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'Electrical.form12', 'نظام السخانات صورة واحد'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'Electrical.form12', 'نظام السخانات صورة اثنين'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'النوع',
                      dropdownItems: ['كهرباء', 'طاقة متجدده'],
                      selectedDropdownItem: controller
                          .inspectionData['Electrical.form12_النوع'] ??
                          'النوع',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'Electrical.form12', 'النوع', value);
                        }
                      },
                    ),

                  ],
                )),






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
