import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/core/constant/imagesassets.dart';
import 'package:ersei/app/core/functions/functioninput.dart';
import 'package:ersei/app/modules/home/controllers/auth/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/class/statusrequest.dart';
import '../widget/customelevetbutton.dart';
import '../widget/custometext.dart';
import '../widget/customtextformfield.dart';

class ResetPasswordView extends GetView<ResetPasswordControllerImp> {
  const ResetPasswordView({super.key});


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, // نسبة من عرض الشاشة
              vertical: screenHeight * 0.02, // نسبة من ارتفاع الشاشة
            ),
            child:GetBuilder<ResetPasswordControllerImp>(
        builder: (controller) {
    if (controller.statuesRequest == StatusRequest.loading) {
    return const Center(
    child: CircularProgressIndicator(),
    );
    }

    return Form(
    key: controller.formstate,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    IconButton(
    onPressed: () => Get.back(),
    icon: const Icon(Icons.arrow_back_ios),
    color: Colors.black54,
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
    text: 'إعادة تعيين كلمة السر ',
    alignment: Alignment.center,
    fontWeight: FontWeight.bold,
    fontSize: 26,
    ),
    ),
    const SizedBox(height: 10),
    const Center(
    child: CustomText(
    maxLine: 1,
    text: 'أدخل رقم هاتفك وبريدك الالكتروني ',
    alignment: Alignment.center,
    fontWeight: FontWeight.bold,
    fontSize: 13,
    color: Colors.black38,
    ),
    ),
    const SizedBox(height: 30),
    CustomTextFormField(
    validator: (val){
    return validInput(val!, 8, 10, 'phone');
    },
    textAlign: TextAlign.right,
    hintStyle:const TextStyle(color: Colors.black38),
    contentPadding:const EdgeInsets.symmetric(horizontal: 20, vertical: 16) ,
    hintText: 'الهاتف',
    filled: true,
    fillColor:Colors.white,
    controller: controller.phone ,
    ),
    const SizedBox(height: 15),
    //  CustomTextFormField(
    //    validator: (val){
    //      return validInput(val!, 20, 60, "email");
    //    },
    //    textAlign: TextAlign.right,
    //   hintStyle:const TextStyle(color: Colors.black38),
    //   contentPadding:const EdgeInsets.symmetric(horizontal: 20, vertical: 16) ,
    //   hintText: 'الايميل',
    //   filled: true,
    //   fillColor:Colors.white,
    //   controller: controller.email ,
    // ),
    const SizedBox(height: 30),
    SizedBox(
    width: double.infinity,
    child:CustomElevatedButton(
    label: 'التالي',
    backgroundColor: ColorsApp.greencolorapp,
    textColor: Colors.white,
    onPressed: controller.resetPassword,
    ),
    ),
    ],
    ),
    );
    }),
        ),
      ),
      ));
  }
}
