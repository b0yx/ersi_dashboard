import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/core/constant/imagesassets.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/signup_controller.dart';
import '../widget/customelevetbutton.dart';
import '../widget/customiconbutton.dart';
import '../widget/customtextformfield.dart';

class SignupView extends GetView<SignupControllerImp> {
  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                Center(
                  child: CustomText(
                    maxLine: 1,
                    text: 'إنشاء حساب',
                    fontSize: 26,
                    alignment: Alignment.center,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: CustomText(
                    maxLine: 1,
                    text: 'أدخل البيانات المطلوبة ليتم إنشاء الحساب',
                    fontSize: 12,
                    color: Colors.black38,
                    alignment: Alignment.center,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  hintText: 'الأسم',
                  filled: true,
                  textalign: TextAlign.right,
                  fillColor: Colors.white,
                  hintstyle: const TextStyle(color: Colors.black38),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  controller: controller.name,
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  hintText: 'الأيميل',
                  filled: true,
                  textalign: TextAlign.right,
                  fillColor: Colors.white,
                  hintstyle: const TextStyle(color: Colors.black38),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  controller: controller.email,
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  hintText: 'الهاتف',
                  filled: true,
                  textalign: TextAlign.right,
                  fillColor: Colors.white,
                  hintstyle: const TextStyle(color: Colors.black38),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  controller: controller.phone,
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  hintText: 'كلمة السر',
                  filled: true,
                  textalign: TextAlign.right,
                  fillColor: Colors.white,
                  hintstyle: const TextStyle(color: Colors.black38),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  controller: controller.password,
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  hintText: 'تأكيد كلمة السر',
                  filled: true,
                  textalign: TextAlign.right,
                  fillColor: Colors.white,
                  hintstyle: const TextStyle(color: Colors.black38),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  controller: controller.confirmpassword,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    label: 'إنشاء',
                    backgroundColor: ColorsApp.greencolorapp,
                    textColor: Colors.white,
                    onPressed: controller.creataccoutn,
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
