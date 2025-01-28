import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/modules/home/views/widget/customimageform.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/architectural_inspection_controller.dart';

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
                return CustomImageForm(
                firstImage: controller.firstImage.value,
                secondImage: controller.secondImage.value,
                onPickFirstImage: controller.pickFirstImage,
                onPickSecondImage: controller.pickSecondImage,
                  formNAme: '  أ - مطابقة المنفذ مع المخطط ',

                  );}

               ),
              // _buildPlanMatchingSection(),
              const SizedBox(height: 20),
              // _buildMaterialsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to next page
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF96E6B3),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text(
            'NEXT',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }





}
