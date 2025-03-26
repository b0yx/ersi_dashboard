import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/colors.dart';
import '../../../../routes/app_pages.dart';


import '../../controllers/survey_works_controller.dart';
import '../widget/custom_dropdown.dart';
import '../widget/custom_image_with_muldropdownlist.dart';
import '../widget/customelevetbutton.dart';
import '../widget/custometext.dart';

class SurveyWorksInspectionView extends GetView<SurveyWorksInspectionControllerImp> {
  const SurveyWorksInspectionView({Key? key}) : super(key: key);

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
            text: 'الاعمال المساحية',
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // دراسة فحص التربة
                Obx(() => CustomImageMulForm(
                  formName: "مطابقة المخطط مع المنفذ 1",
                  firstImageLabel: "صورة ",
                  secondImageLabel: "صورة ",
                  firstImagePath:
                  controller.inspectionData['SurveyWorks.form1_التقرير مخطط'],
                  secondImagePath:
                  controller.inspectionData['SurveyWorks.form1_التقرير منفذ'],
                  onPickFirstImage: () =>
                      controller.pickImage(context, 'SurveyWorks.form1', 'التقرير مخطط'),
                  onPickSecondImage: () =>
                      controller.pickImage(context, 'SurveyWorks.form1', 'التقرير منفذ'),
                  dropdowns: [
                    CustomDropdownField(
                      dropdownLabel: 'مساحة الأرض',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['SurveyWorks.form1_مساحة الأرض'] ??
                          'مساحة الأرض',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'SurveyWorks.form1', 'مساحة الأرض', value);
                        }
                      },
                    ),
                    CustomDropdownField(
                      dropdownLabel: 'مساحة المبنى',
                      dropdownItems: ['مطابق', 'غير مطابق'],
                      selectedDropdownItem: controller
                          .inspectionData['SurveyWorks.form1_مساحة المبنى'] ??
                          'مساحة المبنى',
                      onDropdownChanged: (value) {
                        if (value != null) {
                          controller.updateValue(
                              'SurveyWorks.form1', 'مساحة المبنى', value);
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
