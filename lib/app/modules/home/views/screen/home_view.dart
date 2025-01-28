import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/core/constant/imagesassets.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:ersei/app/modules/home/views/widget/custometextbutton.dart';
import 'package:ersei/app/modules/home/views/widget/customicon.dart';
import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class HomeView extends GetView<HomeControllerImp> {
   final customIcons = CustomIcons(defaultSize: 20,defaultColor: ColorsApp.greencolorapp);
   final customtextbutton = CustomTextButton();
   // final HomeControllerImp controllerImp = Get.find();

  HomeView({super.key});


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  ImageAssets.applogo,
                  height: 60,
                ),
              ),
              const SizedBox(height: 20),
              CustomText(maxLine: 1,
                text: '${controller.userName} مرحبا بعودتك ',
                fontSize: 30,
                alignment: Alignment.center,),

              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 5),
                  Icon(Icons.history,color:ColorsApp.greencolorapp ,),
                  CustomText(maxLine: 1,text: 'التقارير الاخيرة',),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: List.generate(
                    5,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            ImageAssets.applogo,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          index % 2 == 0
                              ? 'مبنى وزارة المالية'
                              : 'مبنى المدينة للطيران',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          index % 2 == 0 ? 'فحص تفصيلي' : 'فحص جزئي',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child:customtextbutton.textButton(label: 'فحص جديد',
                    icon:customIcons.icon(Icons.add_circle_outline),
                    onPressed: () => Get.toNamed(Routes.CREATE_PROJECT,)
        
                // TextButton(
                //   onPressed: () => Get.toNamed(Routes.CREATE_PROJECT),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       const Icon(
                //         Icons.add_circle_outline,
                //         color: Color(0xFF96E6B3),
                //       ),
                //       const SizedBox(width: 8),
                //       Text(
                //         'اضافة تقرير فحص جديد',
                //         style: TextStyle(
                //           color: Colors.grey[600],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ),
              ),],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Get.toNamed(Routes.CREATE_PROJECT),
      //   backgroundColor: const Color(0xFF96E6B3),
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),
    );
  }
}
