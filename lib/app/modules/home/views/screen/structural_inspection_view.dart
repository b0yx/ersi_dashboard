import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/modules/home/views/widget/customelevetbutton.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:ersei/app/modules/home/views/widget/customiconbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/structural_inspection_controller.dart';
import '../widget/custom_dropdown.dart';
import '../widget/custom_image_with_muldropdownlist.dart';
import '../widget/custom_img_with_inputform.dart';

class StructuralInspectionView extends GetView<StructuralInspectionControllerImp> {
  StructuralInspectionView({super.key});
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
            text: 'الفحص الانشائي ',
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
                controller.inspectionData['Structural.form1_مخطط'],
                secondImagePath:
                controller.inspectionData['Structural.form1_منفذ'],
                onPickFirstImage: () =>
                    controller.pickImage(context, 'Structural.form1', 'مخطط'),
                onPickSecondImage: () =>
                    controller.pickImage(context, 'Structural.form1', 'منفذ'),
                dropdowns: [
                  CustomDropdownField(
                    dropdownLabel: 'نسبة التطابق',
                    dropdownItems: ['ممتاز', 'جيد', 'متوسط', 'سيء'],
                    selectedDropdownItem: controller
                        .inspectionData['Structural.form1_نسبة التطابق'] ??
                        'نسبة التطابق',
                    onDropdownChanged: (value) {
                      if (value != null) {
                        controller.updateValue(
                            'Structural.form1', 'نسبة التطابق', value);
                      }
                    },
                  ),
                ],
              )),
              const SizedBox(height: 20),

              // داخل StructuralInspectionView ضمن عمود عناصر الصفحة
              const SizedBox(height: 20),
// فحص القواعد (مثال لنموذج متكرر)
              Obx(() {
                // نستخدم اسم القسم لتحديد النماذج
                String section = "فحص القواعد";
                // في حال عدم وجود بيانات لهذا القسم، يتم تهيئتها
                if (!controller.repeatedInspectionData.containsKey(section)) {
                  controller.addRepeatedForm(section);
                }
                final forms = controller.repeatedInspectionData[section]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "فحص القواعد",
                      alignment: Alignment.center,
                      fontSize: 18,
                      fontWeight: FontWeight.bold, maxLine: 1,
                    ),
                    const SizedBox(height: 10),
                    // بناء النماذج المتكررة باستخدام القائمة
                    ...forms.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> formData = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomImageMulFormWithInputForm(
                          formName: 'فحص عناصر الهيكل الانشائي',
                          sectionName: section,
                          firstImageLabel: "صورة 1",
                          secondImageLabel: "صورة 2",
                          firstImagePath: formData['image1'],
                          secondImagePath: formData['image2'],
                          onPickFirstImage: () => controller.pickImageForRepeated(section, index, "image1"),
                          onPickSecondImage: () => controller.pickImageForRepeated(section, index, "image2"),
                          inputController: controller.getInputController(section, index),
                          outputRx: controller.getOutputRx(section, index),
                          inputKey: "قراءة المطرقة",
                          outputKey: "مقاومة الخرسانة",
                          onInputChanged: (value) => controller.updateRepeatedInputValue(section, index, value),
                          dropdowns: [
                            CustomDropdownField(
                              dropdownLabel: 'فحص كمية حديد التسليح',
                              dropdownItems: ['مطابق', 'غير مطابق'],
                              selectedDropdownItem: formData['reinforcement'] ?? 'المطابقة',
                              onDropdownChanged: (value) {
                                if (value != null) {
                                  controller.updateRepeatedDropdownValue(section, index, "reinforcement", value);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    // زر لإضافة نموذج جديد للقسم
                    Center(
                       child:CustomIconButton(
                        icon: Icons.add_circle,
                        color: Colors.green,

                        onPressed: () => controller.addRepeatedForm(section),
                       )

                      // ElevatedButton(
                      //   onPressed: () => controller.addRepeatedForm(section),
                      //   child: const Text("إضافة"),
                      // ),
                    ),
                  ],
                );
              }),
              //فحص القواعد
              // Obx(() =>  CustomImageMulFormWithInputForm(
              //   formName: 'فحص عناصر الهيكل الانشائي ',
              //   sectionName: "فحص القواعد",
              //   firstImageLabel: "صورة 1",
              //   secondImageLabel: "صورة 2",
              //   firstImagePath:controller.inspectionData['Structural.form2_القواعد واحد'],
              //   secondImagePath: controller.inspectionData['Structural.form2_القواعد اثنين'],
              //   onPickFirstImage: () =>
              //       controller.pickImage(context, 'Structural.form2', 'القواعد واحد'),
              //   onPickSecondImage: () =>
              //       controller.pickImage(context, 'Structural.form2', 'القواعد اثنين'),
              //   inputController: controller.hammerInputControllers.putIfAbsent("Structural.form2", () => TextEditingController()),
              //   outputRx: controller.hammerOutputRxMap.putIfAbsent("Structural.form2", () => ''.obs),
              //   inputKey: "قراءة المطرقة",
              //   outputKey: "مقاومة الخرسانة",
              //   onInputChanged: (value) {
              //     controller.updateInputValue("Structural.form2", "قراءة المطرقة", value);
              //   },
              //   dropdowns: [
              //     //فحص كمية حديد التسليح
              //     CustomDropdownField(
              //       dropdownLabel: 'فحص كمية حديد التسليح',
              //       dropdownItems: ['مطابق', 'غير مطابق'],
              //       selectedDropdownItem: controller
              //           .inspectionData['Structural.form2_فحص كمية حديد التسليح'] ??
              //           'المطابقة',
              //       onDropdownChanged: (value) {
              //         if (value != null) {
              //           controller.updateValue(
              //               'Structural.form2', 'فحص كمية حديد التسليح', value);
              //         }
              //       },
              //     ),
              //
              //
              //
              //
              //
              //   ],
              // )),
              const SizedBox(height: 20),
              // فحص الاعمدة
              Obx(() {
                // نستخدم اسم القسم لتحديد النماذج
                String section = "فحص الاعمدة";
                // في حال عدم وجود بيانات لهذا القسم، يتم تهيئتها
                if (!controller.repeatedInspectionData.containsKey(section)) {
                  controller.addRepeatedForm(section);
                }
                final forms = controller.repeatedInspectionData[section]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "فحص الاعمدة",
                      alignment: Alignment.center,
                      fontSize: 18,
                      fontWeight: FontWeight.bold, maxLine: 1,
                    ),
                    const SizedBox(height: 10),
                    // بناء النماذج المتكررة باستخدام القائمة
                    ...forms.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> formData = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomImageMulFormWithInputForm(
                          formName: 'فحص عناصر الهيكل الانشائي',
                          sectionName: section,
                          firstImageLabel: "صورة 1",
                          secondImageLabel: "صورة 2",
                          firstImagePath: formData['image1'],
                          secondImagePath: formData['image2'],
                          onPickFirstImage: () => controller.pickImageForRepeated(section, index, "image1"),
                          onPickSecondImage: () => controller.pickImageForRepeated(section, index, "image2"),
                          inputController: controller.getInputController(section, index),
                          outputRx: controller.getOutputRx(section, index),
                          inputKey: "قراءة المطرقة",
                          outputKey: "مقاومة الخرسانة",
                          onInputChanged: (value) => controller.updateRepeatedInputValue(section, index, value),
                          dropdowns: [
                            CustomDropdownField(
                              dropdownLabel: 'فحص كمية حديد التسليح',
                              dropdownItems: ['مطابق', 'غير مطابق'],
                              selectedDropdownItem: formData['reinforcement'] ?? 'المطابقة',
                              onDropdownChanged: (value) {
                                if (value != null) {
                                  controller.updateRepeatedDropdownValue(section, index, "reinforcement", value);
                                }
                              },
                            ),
                            CustomDropdownField(
                              dropdownLabel: 'المحاور',
                              dropdownItems: ['مطابق', 'غير مطابق'],
                              selectedDropdownItem: formData['reinforcement'] ?? 'المطابقة',
                              onDropdownChanged: (value) {
                                if (value != null) {
                                  controller.updateRepeatedDropdownValue(section, index, "reinforcement", value);
                                }
                              },
                            ),
                            CustomDropdownField(
                              dropdownLabel: 'الاستقامة الرأسية',
                              dropdownItems: ['مطابق', 'غير مطابق'],
                              selectedDropdownItem: formData['reinforcement'] ?? 'المطابقة',
                              onDropdownChanged: (value) {
                                if (value != null) {
                                  controller.updateRepeatedDropdownValue(section, index, "reinforcement", value);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    // زر لإضافة نموذج جديد للقسم
                    Center(
                        child:CustomIconButton(
                          icon: Icons.add_circle,
                          color: Colors.green,

                          onPressed: () => controller.addRepeatedForm(section),
                        )

                      // ElevatedButton(
                      //   onPressed: () => controller.addRepeatedForm(section),
                      //   child: const Text("إضافة"),
                      // ),
                    ),
                  ],
                );
              }),
              // Obx(() =>  CustomImageMulFormWithInputForm(
              //   formName: 'فحص عناصر الهيكل الانشائي ',
              //   sectionName: "فحص الاعمدة",
              //   firstImageLabel: "صورة 1",
              //   secondImageLabel: "صورة 2",
              //   firstImagePath:controller.inspectionData['Structural.form3_الاعمدة واحد'],
              //   secondImagePath: controller.inspectionData['Structural.form3_الاعمدة اثنين'],
              //   onPickFirstImage: () =>
              //       controller.pickImage(context, 'Structural.form3', 'الاعمدة واحد'),
              //   onPickSecondImage: () =>
              //       controller.pickImage(context, 'Structural.form3', 'الاعمدة اثنين'),
              //   inputController: controller.hammerInputControllers.putIfAbsent("Structural.form3", () => TextEditingController()),
              //   outputRx: controller.hammerOutputRxMap.putIfAbsent("Structural.form3", () => ''.obs),
              //   inputKey: "قراءة المطرقة",
              //   outputKey: "مقاومة الخرسانة",
              //   onInputChanged: (value) {
              //     controller.updateInputValue("Structural.form3", "قراءة المطرقة", value);
              //   },
              //   dropdowns: [
              //     //فحص كمية حديد التسليح
              //     CustomDropdownField(
              //       dropdownLabel: 'فحص كمية حديد التسليح',
              //       dropdownItems: ['مطابق', 'غير مطابق'],
              //       selectedDropdownItem: controller
              //           .inspectionData['Structural.form3_فحص كمية حديد التسليح'] ??
              //           'المطابقة',
              //       onDropdownChanged: (value) {
              //         if (value != null) {
              //           controller.updateValue(
              //               'Structural.form3', 'فحص كمية حديد التسليح', value);
              //         }
              //       },
              //     ),
              //     //فخض الاستقامة الرأسية
              //     CustomDropdownField(
              //       dropdownLabel: 'فحص الاستقامة الرأسية',
              //       dropdownItems: ['مطابق', 'غير مطابق'],
              //       selectedDropdownItem: controller
              //           .inspectionData['Structural.form3_فحص الاستقامة الرأسية'] ??
              //           'المطابقة',
              //       onDropdownChanged: (value) {
              //         if (value != null) {
              //           controller.updateValue(
              //               'Structural.form3', 'فحص الاستقامة الرأسية', value);
              //         }
              //       },
              //     ),
              //     //فحص المحاور
              //     CustomDropdownField(
              //       dropdownLabel: 'فحص المحاور',
              //       dropdownItems: ['مطابق', 'غير مطابق'],
              //       selectedDropdownItem: controller
              //           .inspectionData['Structural.form3_فحص المحاور'] ??
              //           'المطابقة',
              //       onDropdownChanged: (value) {
              //         if (value != null) {
              //           controller.updateValue(
              //               'Structural.form3', 'فحص المحاور', value);
              //         }
              //       },
              //     ),
              //
              //
              //
              //
              //   ],
              // )),
              const SizedBox(height: 20),
              //فحص الميد
              Obx(() {
                // نستخدم اسم القسم لتحديد النماذج
                String section = "فحص الميد";
                // في حال عدم وجود بيانات لهذا القسم، يتم تهيئتها
                if (!controller.repeatedInspectionData.containsKey(section)) {
                  controller.addRepeatedForm(section);
                }
                final forms = controller.repeatedInspectionData[section]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "فحص الميد",
                      alignment: Alignment.center,
                      fontSize: 18,
                      fontWeight: FontWeight.bold, maxLine: 1,
                    ),
                    const SizedBox(height: 10),
                    // بناء النماذج المتكررة باستخدام القائمة
                    ...forms.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> formData = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomImageMulFormWithInputForm(
                          formName: 'فحص عناصر الهيكل الانشائي',
                          sectionName: section,
                          firstImageLabel: "صورة 1",
                          secondImageLabel: "صورة 2",
                          firstImagePath: formData['image1'],
                          secondImagePath: formData['image2'],
                          onPickFirstImage: () => controller.pickImageForRepeated(section, index, "image1"),
                          onPickSecondImage: () => controller.pickImageForRepeated(section, index, "image2"),
                          inputController: controller.getInputController(section, index),
                          outputRx: controller.getOutputRx(section, index),
                          inputKey: "قراءة المطرقة",
                          outputKey: "مقاومة الخرسانة",
                          onInputChanged: (value) => controller.updateRepeatedInputValue(section, index, value),
                          dropdowns: [
                            CustomDropdownField(
                              dropdownLabel: 'فحص كمية حديد التسليح',
                              dropdownItems: ['مطابق', 'غير مطابق'],
                              selectedDropdownItem: formData['reinforcement'] ?? 'المطابقة',
                              onDropdownChanged: (value) {
                                if (value != null) {
                                  controller.updateRepeatedDropdownValue(section, index, "reinforcement", value);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    // زر لإضافة نموذج جديد للقسم
                    Center(
                        child:CustomIconButton(
                          icon: Icons.add_circle,
                          color: Colors.green,

                          onPressed: () => controller.addRepeatedForm(section),
                        )

                      // ElevatedButton(
                      //   onPressed: () => controller.addRepeatedForm(section),
                      //   child: const Text("إضافة"),
                      // ),
                    ),
                  ],
                );
              }),

              //فحص الميد
              // Obx(() =>  CustomImageMulFormWithInputForm(
              //   formName: 'فحص عناصر الهيكل الانشائي ',
              //   sectionName: "فحص الميد",
              //   firstImageLabel: "صورة 1",
              //   secondImageLabel: "صورة 2",
              //   firstImagePath:controller.inspectionData['Structural.form4_الميد واحد'],
              //   secondImagePath: controller.inspectionData['Structural.form4_الميد اثنين'],
              //   onPickFirstImage: () =>
              //       controller.pickImage(context, 'Structural.form4', 'الميد واحد'),
              //   onPickSecondImage: () =>
              //       controller.pickImage(context, 'Structural.form4', 'الميد اثنين'),
              //   inputController: controller.hammerInputControllers.putIfAbsent("Structural.form4", () => TextEditingController()),
              //   outputRx: controller.hammerOutputRxMap.putIfAbsent("Structural.form4", () => ''.obs),
              //   inputKey: "قراءة المطرقة",
              //   outputKey: "مقاومة الخرسانة",
              //   onInputChanged: (value) {
              //     controller.updateInputValue("Structural.form4", "قراءة المطرقة", value);
              //   },
              //   dropdowns: [
              //     //فحص كمية حديد التسليح
              //     CustomDropdownField(
              //       dropdownLabel: 'فحص كمية حديد التسليح',
              //       dropdownItems: ['مطابق', 'غير مطابق'],
              //       selectedDropdownItem: controller
              //           .inspectionData['Structural.form4_فحص كمية حديد التسليح'] ??
              //           'المطابقة',
              //       onDropdownChanged: (value) {
              //         if (value != null) {
              //           controller.updateValue(
              //               'Structural.form4', 'فحص كمية حديد التسليح', value);
              //         }
              //       },
              //     ),
              //
              //
              //
              //
              //
              //   ],
              // )),
              const SizedBox(height: 20),
              //فحص الجسور
              Obx(() {
                // نستخدم اسم القسم لتحديد النماذج
                String section = "فحص الجسور";
                // في حال عدم وجود بيانات لهذا القسم، يتم تهيئتها
                if (!controller.repeatedInspectionData.containsKey(section)) {
                  controller.addRepeatedForm(section);
                }
                final forms = controller.repeatedInspectionData[section]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "فحص الجسور",
                      alignment: Alignment.center,
                      fontSize: 18,
                      fontWeight: FontWeight.bold, maxLine: 1,
                    ),
                    const SizedBox(height: 10),
                    // بناء النماذج المتكررة باستخدام القائمة
                    ...forms.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> formData = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomImageMulFormWithInputForm(
                          formName: 'فحص عناصر الهيكل الانشائي',
                          sectionName: section,
                          firstImageLabel: "صورة 1",
                          secondImageLabel: "صورة 2",
                          firstImagePath: formData['image1'],
                          secondImagePath: formData['image2'],
                          onPickFirstImage: () => controller.pickImageForRepeated(section, index, "image1"),
                          onPickSecondImage: () => controller.pickImageForRepeated(section, index, "image2"),
                          inputController: controller.getInputController(section, index),
                          outputRx: controller.getOutputRx(section, index),
                          inputKey: "قراءة المطرقة",
                          outputKey: "مقاومة الخرسانة",
                          onInputChanged: (value) => controller.updateRepeatedInputValue(section, index, value),
                          dropdowns: [
                            CustomDropdownField(
                              dropdownLabel: 'فحص كمية حديد التسليح',
                              dropdownItems: ['مطابق', 'غير مطابق'],
                              selectedDropdownItem: formData['reinforcement'] ?? 'المطابقة',
                              onDropdownChanged: (value) {
                                if (value != null) {
                                  controller.updateRepeatedDropdownValue(section, index, "reinforcement", value);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    // زر لإضافة نموذج جديد للقسم
                    Center(
                        child:CustomIconButton(
                          icon: Icons.add_circle,
                          color: Colors.green,

                          onPressed: () => controller.addRepeatedForm(section),
                        )

                      // ElevatedButton(
                      //   onPressed: () => controller.addRepeatedForm(section),
                      //   child: const Text("إضافة"),
                      // ),
                    ),
                  ],
                );
              }),
              // Obx(() =>  CustomImageMulFormWithInputForm(
              //   formName: 'فحص عناصر الهيكل الانشائي ',
              //   sectionName: "فحص الجسور",
              //   firstImageLabel: "صورة 1",
              //   secondImageLabel: "صورة 2",
              //   firstImagePath:controller.inspectionData['Structural.form5_الجسور واحد'],
              //   secondImagePath: controller.inspectionData['Structural.form5_الجسور اثنين'],
              //   onPickFirstImage: () =>
              //       controller.pickImage(context, 'Structural.form5', 'الجسور واحد'),
              //   onPickSecondImage: () =>
              //       controller.pickImage(context, 'Structural.form5', 'الجسور اثنين'),
              //   inputController: controller.hammerInputControllers.putIfAbsent("Structural.form5", () => TextEditingController()),
              //   outputRx: controller.hammerOutputRxMap.putIfAbsent("Structural.form5", () => ''.obs),
              //   inputKey: "قراءة المطرقة",
              //   outputKey: "مقاومة الخرسانة",
              //   onInputChanged: (value) {
              //     controller.updateInputValue("Structural.form5", "قراءة المطرقة", value);
              //   },
              //   dropdowns: [
              //     //فحص كمية حديد التسليح
              //     CustomDropdownField(
              //       dropdownLabel: 'فحص كمية حديد التسليح',
              //       dropdownItems: ['مطابق', 'غير مطابق'],
              //       selectedDropdownItem: controller
              //           .inspectionData['Structural.form5_فحص كمية حديد التسليح'] ??
              //           'المطابقة',
              //       onDropdownChanged: (value) {
              //         if (value != null) {
              //           controller.updateValue(
              //               'Structural.form5', 'فحص كمية حديد التسليح', value);
              //         }
              //       },
              //     ),
              //
              //
              //
              //
              //
              //   ],
              // )),
              const SizedBox(height: 20),

              //فحص الاسقف
              Obx(() {
                // نستخدم اسم القسم لتحديد النماذج
                String section = "فحص الأسقف";
                // في حال عدم وجود بيانات لهذا القسم، يتم تهيئتها
                if (!controller.repeatedInspectionData.containsKey(section)) {
                  controller.addRepeatedForm(section);
                }
                final forms = controller.repeatedInspectionData[section]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "فحص الأسقف",
                      alignment: Alignment.center,
                      fontSize: 18,
                      fontWeight: FontWeight.bold, maxLine: 1,
                    ),
                    const SizedBox(height: 10),
                    // بناء النماذج المتكررة باستخدام القائمة
                    ...forms.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> formData = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomImageMulFormWithInputForm(
                          formName: 'فحص عناصر الهيكل الانشائي',
                          sectionName: section,
                          firstImageLabel: "صورة 1",
                          secondImageLabel: "صورة 2",
                          firstImagePath: formData['image1'],
                          secondImagePath: formData['image2'],
                          onPickFirstImage: () => controller.pickImageForRepeated(section, index, "image1"),
                          onPickSecondImage: () => controller.pickImageForRepeated(section, index, "image2"),
                          inputController: controller.getInputController(section, index),
                          outputRx: controller.getOutputRx(section, index),
                          inputKey: "قراءة المطرقة",
                          outputKey: "مقاومة الخرسانة",
                          onInputChanged: (value) => controller.updateRepeatedInputValue(section, index, value),
                          dropdowns: [
                            CustomDropdownField(
                              dropdownLabel: 'فحص كمية حديد التسليح',
                              dropdownItems: ['مطابق', 'غير مطابق'],
                              selectedDropdownItem: formData['reinforcement'] ?? 'المطابقة',
                              onDropdownChanged: (value) {
                                if (value != null) {
                                  controller.updateRepeatedDropdownValue(section, index, "reinforcement", value);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    // زر لإضافة نموذج جديد للقسم
                    Center(
                        child:CustomIconButton(
                          icon: Icons.add_circle,
                          color: Colors.green,

                          onPressed: () => controller.addRepeatedForm(section),
                        )

                      // ElevatedButton(
                      //   onPressed: () => controller.addRepeatedForm(section),
                      //   child: const Text("إضافة"),
                      // ),
                    ),
                  ],
                );
              }),
            //   Obx(() =>  CustomImageMulFormWithInputForm(
            //     formName: 'فحص عناصر الهيكل الانشائي ',
            //     sectionName: "فحص الاسقف",
            //     firstImageLabel: "صورة 1",
            //     secondImageLabel: "صورة 2",
            //     firstImagePath:controller.inspectionData['Structural.form6_الاسقف واحد'],
            //     secondImagePath: controller.inspectionData['Structural.form6_الاسقف اثنين'],
            //     onPickFirstImage: () =>
            //         controller.pickImage(context, 'Structural.form6', 'الاسقف واحد'),
            //     onPickSecondImage: () =>
            //         controller.pickImage(context, 'Structural.form6', 'الاسقف اثنين'),
            //     inputController: controller.hammerInputControllers.putIfAbsent("Structural.form6", () => TextEditingController()),
            //     outputRx: controller.hammerOutputRxMap.putIfAbsent("Structural.form6", () => ''.obs),
            //     inputKey: "قراءة المطرقة",
            //     outputKey: "مقاومة الخرسانة",
            //     onInputChanged: (value) {
            //       controller.updateInputValue("Structural.form6", "قراءة المطرقة", value);
            //     },
            //     dropdowns: [
            //       //فحص كمية حديد التسليح
            //       CustomDropdownField(
            //         dropdownLabel: 'فحص كمية حديد التسليح',
            //         dropdownItems: ['مطابق', 'غير مطابق'],
            //         selectedDropdownItem: controller
            //             .inspectionData['Structural.form6_فحص كمية حديد التسليح'] ??
            //             'المطابقة',
            //         onDropdownChanged: (value) {
            //           if (value != null) {
            //             controller.updateValue(
            //                 'Structural.form6', 'فحص كمية حديد التسليح', value);
            //           }
            //         },
            //       ),
            //       //فحص الاستقامة الافقية   ]0
            //
            //
            // ],
            //   )),
              const SizedBox(height: 20),
              //فحص غرفة المصعد
              Obx(() {
                // نستخدم اسم القسم لتحديد النماذج
                String section = "فحص غرفة المصعد";
                // في حال عدم وجود بيانات لهذا القسم، يتم تهيئتها
                if (!controller.repeatedInspectionData.containsKey(section)) {
                  controller.addRepeatedForm(section);
                }
                final forms = controller.repeatedInspectionData[section]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "فحص غرفة المصعد",
                      alignment: Alignment.center,
                      fontSize: 18,
                      fontWeight: FontWeight.bold, maxLine: 1,
                    ),
                    const SizedBox(height: 10),
                    // بناء النماذج المتكررة باستخدام القائمة
                    ...forms.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> formData = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomImageMulFormWithInputForm(
                          formName: 'فحص عناصر الهيكل الانشائي',
                          sectionName: section,
                          firstImageLabel: "صورة 1",
                          secondImageLabel: "صورة 2",
                          firstImagePath: formData['image1'],
                          secondImagePath: formData['image2'],
                          onPickFirstImage: () => controller.pickImageForRepeated(section, index, "image1"),
                          onPickSecondImage: () => controller.pickImageForRepeated(section, index, "image2"),
                          inputController: controller.getInputController(section, index),
                          outputRx: controller.getOutputRx(section, index),
                          inputKey: "قراءة المطرقة",
                          outputKey: "مقاومة الخرسانة",
                          onInputChanged: (value) => controller.updateRepeatedInputValue(section, index, value),
                          dropdowns: [
                            CustomDropdownField(
                              dropdownLabel: 'فحص كمية حديد التسليح',
                              dropdownItems: ['مطابق', 'غير مطابق'],
                              selectedDropdownItem: formData['reinforcement'] ?? 'المطابقة',
                              onDropdownChanged: (value) {
                                if (value != null) {
                                  controller.updateRepeatedDropdownValue(section, index, "reinforcement", value);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    // زر لإضافة نموذج جديد للقسم
                    Center(
                        child:CustomIconButton(
                          icon: Icons.add_circle,
                          color: Colors.green,

                          onPressed: () => controller.addRepeatedForm(section),
                        )

                      // ElevatedButton(
                      //   onPressed: () => controller.addRepeatedForm(section),
                      //   child: const Text("إضافة"),
                      // ),
                    ),
                  ],
                );
              }),
              // Obx(() =>  CustomImageMulFormWithInputForm(
              //   formName: 'فحص عناصر الهيكل الانشائي ',
              //   sectionName: "فحص غرفة المصعد",
              //   firstImageLabel: "صورة 1",
              //   secondImageLabel: "صورة 2",
              //   firstImagePath:controller.inspectionData['Structural.form7_غرفة المصعد واحد'],
              //   secondImagePath: controller.inspectionData['Structural.form7_غرفة المصعد اثنين'],
              //   onPickFirstImage: () =>
              //       controller.pickImage(context, 'Structural.form7', 'غرفة المصعد واحد'),
              //   onPickSecondImage: () =>
              //       controller.pickImage(context, 'Structural.form7', 'غرفة المصعد اثنين'),
              //   inputController: controller.hammerInputControllers.putIfAbsent("Structural.form7", () => TextEditingController()),
              //   outputRx: controller.hammerOutputRxMap.putIfAbsent("Structural.form7", () => ''.obs),
              //   inputKey: "قراءة المطرقة",
              //   outputKey: "مقاومة الخرسانة",
              //   onInputChanged: (value) {
              //     controller.updateInputValue("Structural.form7", "قراءة المطرقة", value);
              //   },
              //   dropdowns: [
              //     //فحص كمية حديد التسليح
              //     CustomDropdownField(
              //       dropdownLabel: 'فحص كمية حديد التسليح',
              //       dropdownItems: ['مطابق', 'غير مطابق'],
              //       selectedDropdownItem: controller
              //           .inspectionData['Structural.form7_فحص كمية حديد التسليح'] ??
              //           'المطابقة',
              //       onDropdownChanged: (value) {
              //         if (value != null) {
              //           controller.updateValue(
              //               'Structural.form7', 'فحص كمية حديد التسليح', value);
              //         }
              //       },
              //     ),
              //       ])),
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
