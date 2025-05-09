import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/core/constant/imagesassets.dart';
import 'package:ersei/app/modules/home/controllers/auth/login_controller.dart';
import 'package:ersei/app/modules/home/views/widget/customelevetbutton.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:ersei/app/modules/home/views/widget/custometextbutton.dart';
import 'package:ersei/app/modules/home/views/widget/customiconbutton.dart';
import 'package:ersei/app/modules/home/views/widget/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/class/handlingdataview.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/functions/functioninput.dart';



class LoginView extends GetView {
   LoginView({super.key});

  final LoginControllerImp controller = Get.find();
  final customtextbutton = CustomTextButton();


  @override
  Widget build(BuildContext context) {
    // الحصول على أبعاد الشاشة
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp,
      body: SafeArea(
        child: SingleChildScrollView(
          child:
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, // نسبة من عرض الشاشة
              vertical: screenHeight * 0.02, // نسبة من ارتفاع الشاشة
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomIconButton(
                  icon: Icons.arrow_back_ios_new,
                  onPressed:  () => Get.back(),
                  color: Colors.grey,
                ),
                SizedBox(height: screenHeight * 0.01), // مسافة ديناميكية
                Center(
                  child: Image.asset(
                    ImageAssets.applogo,
                    height: screenHeight * 0.08, // نسبة من ارتفاع الشاشة
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Center(
                  child: CustomText(
                    maxLine: 1,
                    text: 'تسجيل الدخول',
                    fontSize: screenHeight * 0.03, // حجم ديناميكي للنص
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                 GetBuilder<LoginControllerImp>(
                    builder: (controller) => controller.statuesRequest == StatusRequest.loading
                           ? const Center(child: HandlingDataView(
                           statusRequest: StatusRequest.loading, widget: Center()),
                         ) : Form(
                    key:controller.formstate ,
                    child:
                    Column(
                      children: [
                        CustomTextFormField(
                          validator: (val){
                            return validInput(val!, 8, 50, "phone");
                          },
                         hintText: 'الايميل او رقم الهاتف ',
                         filled: true,
                         textAlign: TextAlign.right,
                         fillColor: Colors.white,
                         hintStyle:const TextStyle(color: Colors.black38),
                         contentPadding:const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                         controller: controller.phone,
                                        ),

                                    SizedBox(height: screenHeight * 0.02),
                        CustomTextFormField(
                          validator: (val){
                            return validInput(val!, 8, 16, "password");
                          },
                          hintText: 'كلمة المرور ',
                          obscureText: true,
                          filled: true,
                          textAlign: TextAlign.right,
                          fillColor: Colors.white,
                          hintStyle:const TextStyle(color: Colors.black38),
                          contentPadding:const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          controller: controller.password,
                        ),
                                    SizedBox(height: screenHeight * 0.03),
                                    SizedBox(
                     width: double.infinity,
                     child: CustomElevatedButton(
                       label: 'تسجيل الدخول',
                       backgroundColor: ColorsApp.greencolorapp,
                       textColor: Colors.white,
                       onPressed:controller.login,
                     ),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Center(
                     child:customtextbutton.textButton(
                         label: 'هل نسيت كلمة السر ؟',
                         onPressed:controller.forgetpassword,


                     )
                                    )
                      ],
                                    ),
                  ),
                                  )],
            ),
          ),
        ),
      ),
    );
  }
}
