import 'package:ersei/app/core/class/handlingdataview.dart';
import 'package:ersei/app/core/class/statusrequest.dart';
import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/core/constant/imagesassets.dart';
import 'package:ersei/app/core/functions/functioninput.dart';
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
              child:GetBuilder<SignupControllerImp>(
                builder: (controller) => controller.statuesRequest == StatusRequest.loading
                    ? const Center(child: HandlingDataView(
                    statusRequest: StatusRequest.loading, widget: Center()),
                ) : Form(
                  key: controller.formstate,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: CustomText(
                          maxLine: 1,
                          text: 'إنشاء حساب',
                          fontSize: 26,
                          alignment: Alignment.center,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Center(
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
                        keyboardType: TextInputType.name,
                        validator: (val) {
                          return validInput(val!, 7, 50, "username");
                        },
                        hintText: 'الأسم',
                        filled: true,
                        textAlign: TextAlign.right,
                        fillColor: Colors.white,
                        hintStyle: const TextStyle(color: Colors.black38),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        controller: controller.name,
                      ),
                      const SizedBox(height: 15),

                      CustomTextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'لا يجب أن يكون الحقل فارغًا';
                          }
                          return validInput(val, 8, 10, "phone");
                        },
                        keyboardType: TextInputType.phone,
                        hintText: 'الهاتف',
                        filled: true,
                        textAlign: TextAlign.right,
                        fillColor: Colors.white,
                        hintStyle: const TextStyle(color: Colors.black38),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        controller: controller.phone,
                      ),

                      const SizedBox(height: 15),


                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          return validInput(val!, 10, 100, "email");
                        },
                        hintText: 'الأيميل',
                        filled: true,
                        textAlign: TextAlign.right,
                        fillColor: Colors.white,
                        hintStyle: const TextStyle(color: Colors.black38),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        controller: controller.email,
                      ),

                      const SizedBox(height: 15),
                      CustomTextFormField(
                        obscureText: true,
                        validator: (val) {
                          return validInput(val!,8, 100, "password");
                        },
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'كلمة السر',
                        filled: true,
                        textAlign: TextAlign.right,
                        fillColor: Colors.white,
                        hintStyle: const TextStyle(color: Colors.black38),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        controller: controller.password,
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'تأكيد كلمة السر',
                        filled: true,
                        textAlign: TextAlign.right,
                        fillColor: Colors.white,
                        hintStyle: const TextStyle(color: Colors.black38),
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
                          onPressed: controller.signup,
                        ),
                      ),
                    ],
                  ),
                ),
                )

            ),

        ),
      ),
    );
  }
}


