import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/core/constant/imagesassets.dart';
import 'package:ersei/app/modules/home/views/widget/customelevetbutton.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:ersei/app/modules/home/views/widget/custometextbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../auth/login_view.dart';
import '../auth/signup_view.dart';

class WellcomeView extends GetView<HomeController> {
  WellcomeView({super.key});
  final customtextbutton = CustomTextButton();

  @override
  Widget build(BuildContext context) {
    // استخدام MediaQuery للحصول على أبعاد الشاشة
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Image.asset(
                  ImageAssets.applogo,
                  height: screenHeight * 0.1,
                ),
                Image.asset(
                  ImageAssets.engineerphoto,
                  height: screenHeight * 0.4,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.05,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          backgroundColor: ColorsApp.greencolorapp,
                          icon: Icons.start,
                          label: 'هيا بنا',
                          textColor: Colors.white,
                          onPressed: () => Get.to(() => const SignupView()),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customtextbutton.textButton(
                            label: 'قم بتسجيل الدخول',
                            onPressed: () => Get.to(() => const LoginView()),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          CustomText(
                            maxLine: 1,
                            text: 'هل تمتلك حساب بالفعل؟',
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
