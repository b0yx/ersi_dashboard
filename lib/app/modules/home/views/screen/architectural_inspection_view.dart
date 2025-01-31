import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/modules/home/views/widget/customelevetbutton.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/inspectionstate.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/architectural_inspection_controller.dart';
import '../widget/custom_dropdown.dart';
import '../widget/custom_image_with_muldropdownlist.dart';

class ArchitecturalInspectionView extends GetView<ArchitecturalInspectionControllerImp> {
  ArchitecturalInspectionView({super.key});



  @override
  Widget build(BuildContext context) {
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
              Obx(() {
                return Column(
                  children: [
                    CustomImageMulForm(
                      firstImage: controller.firstImage.value,
                      secondImage: controller.secondImage.value,
                        firstImageName: 'اضافة صورة المنفذ',
                        secondImageName: 'اضافة صورة المخطط',
                      onPickFirstImage: () => controller.pickFirstImage(context),
                      onPickSecondImage: () => controller.pickSecondImage(context),
                      formName: '  أ - مطابقة المنفذ مع المخطط ',

                  dropdowns: [
                  CustomDropdownField(
                    dropdownLabel: 'نسبة التطابق',
                    dropdownItems:const [InspectionState.bad,
                      InspectionState.good,
                      InspectionState.excellent
                    ],
                    selectedDropdownItem:  InspectionState.good,
                    onDropdownChanged: (value) {
                    },
                ),
                  ]
                    ),
                    const SizedBox(height: 20),
                    CustomImageMulForm(
                      firstImage: controller.firstImage.value,
                      secondImage: controller.secondImage.value,
                      onPickFirstImage: () => controller.pickFirstImage(context),
                      onPickSecondImage: () => controller.pickSecondImage(context),
                      formName: 'ب - فحص المواد ',
                      sectionName: 'الجدران',
                      dropdowns: [


                        CustomDropdownField(
                          dropdownLabel: 'الجدران الخارجية',
                          dropdownItems: ['بلوك','طوب '],
                          selectedDropdownItem: 'بلوك',
                          onDropdownChanged: (value) {

                          },
                        ),
                        CustomDropdownField(
                          dropdownLabel: 'الحجم',
                          dropdownItems: ['15','20 '],
                          selectedDropdownItem: '20',
                          onDropdownChanged: (value) {
                          },

                        ),

                        CustomDropdownField(
                          dropdownLabel: 'الجدران الداخلية',
                          dropdownItems: ['بلوك','طوب '],
                          selectedDropdownItem: 'بلوك',
                          onDropdownChanged: (value) {

                          },
                        ),
                        CustomDropdownField(
                          dropdownLabel: 'الحجم ',
                          dropdownItems: ['15','20 '],
                          selectedDropdownItem: '20',
                          onDropdownChanged: (value) {
                          },
                        ),

                        CustomDropdownField(
                          dropdownLabel: 'الاستقامة ',
                          dropdownItems:const [InspectionState.excellent,
                            InspectionState.good,
                            InspectionState.average,
                            InspectionState.bad],
                          selectedDropdownItem: InspectionState.good,
                          onDropdownChanged: (value) {
                          },
                        ),

                        CustomDropdownField(
                          dropdownLabel: 'التعبئة ',
                          dropdownItems:const [InspectionState.excellent,
                            InspectionState.good,
                            InspectionState.average,
                            InspectionState.bad],
                          selectedDropdownItem: InspectionState.good,
                          onDropdownChanged: (value) {
                          },
                        ),
                        CustomDropdownField(
                          dropdownLabel: 'شقوق ',
                          dropdownItems:const [InspectionState.excellent,
                            InspectionState.good,
                            InspectionState.average,
                            InspectionState.bad],
                          selectedDropdownItem: InspectionState.good,
                          onDropdownChanged: (value) {
                          },
                        )

                      ],

                    ),

                  ],
                );
              }
              ),
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
            onPressed: () {  },

          )
      ),
    );
  }
}
