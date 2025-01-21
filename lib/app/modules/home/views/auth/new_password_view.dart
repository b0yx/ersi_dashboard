import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/core/constant/imagesassets.dart';
import 'package:ersei/app/core/functions/functioninput.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:ersei/app/modules/home/views/widget/customiconbutton.dart';
import 'package:ersei/app/modules/home/views/widget/customtextformfield.dart';
import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/new_password_controller.dart';
import '../widget/customelevetbutton.dart';

class NewPasswordView extends GetView<NewPasswordControllerImp> {
  const NewPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:ColorsApp.backgroundforapp,
      body: SafeArea(
        child: SingleChildScrollView(

          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, // نسبة من عرض الشاشة
              vertical: screenHeight * 0.02, // نسبة من ارتفاع الشاشة
            ),
            child: Form(
              key: controller.formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomIconButton(
                    icon: Icons.arrow_back_ios_new,
                    onPressed: () => Get.back(),
                    color: Colors.grey,
                  ),

                  const SizedBox(height: 10),
                  Center(
                    child: Image.asset(
                      ImageAssets.applogo,
                      height: 60,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: CustomText(
                      maxLine: 1,
                      text: 'كلمة السر الجديدة',
                      alignment: Alignment.center,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),

                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: CustomText(
                      maxLine: 1,
                      text: 'أدخل كلمة السر الجديدة',
                      alignment: Alignment.center,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black38,
                    ),
                  ),
                  const SizedBox(height: 30),

                   CustomTextFormField(
                   validator: (val) {
                     return validInput(val!, 5, 100, "phone");
                   },
                      textAlign: TextAlign.right,
                      hintStyle:const TextStyle(color: Colors.black38),
                      contentPadding:const EdgeInsets.symmetric(horizontal: 20, vertical: 16) ,
                      hintText: 'كلمة المرور الجديدة',
                      filled: true,
                      fillColor:Colors.white,
                     controller: controller.password ,
                  ),
                  const SizedBox(height: 15),
                  const CustomTextFormField(textAlign: TextAlign.right,
                    hintStyle:TextStyle(color: Colors.black38),
                    contentPadding:EdgeInsets.symmetric(horizontal: 20, vertical: 16) ,
                    hintText: ' تأكيد كلمة المرور الجديدة',
                    filled: true,
                    fillColor:Colors.white, controller: null ,
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      label: 'تأكيد',
                      backgroundColor: ColorsApp.greencolorapp,
                      textColor: Colors.white,
                      onPressed: () {
                        Get.until((route) => route.settings.name == Routes.LOGINVIEW);
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
