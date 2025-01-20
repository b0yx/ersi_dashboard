import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/core/constant/imagesassets.dart';
import 'package:ersei/app/modules/home/views/widget/custometext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../widget/custometextbutton.dart';


class VerificationCodeView extends GetView {
  VerificationCodeView({super.key});

  final customTextButton = CustomTextButton();

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
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.black54,
                ),
                SizedBox(height: screenHeight * 0.01),
                Center(
                  child: Image.asset(
                    ImageAssets.applogo,

                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Center(
                  child: CustomText(
                    text: 'ادخل رمز التأكيد المرسل \n الى بريدك الالكتروني',
                    alignment: Alignment.center,
                    maxLine: 2,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                OtpTextField(
                  numberOfFields: 4,
                  // borderColor: ColorsApp.greencolorapp,
                  // showFieldAsBox: true,
                  fillColor:Colors.white ,
                  clearText: true,
                  filled: true,



                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return AlertDialog(
                    //       title: const Text("Verification Code"),
                    //       content: Text('Code entered is $verificationCode'),
                    //     );
                    //   },
                    // );
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                Center(
                  child: customTextButton.textButton(
                    label: 'لم يصلني أي رمز تأكيد - إعادة الارسال',

                    onPressed: () {},
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () => Get.to(() => const NewPasswordView()),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color(0xFF96E6B3),
                //       padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //     ),
                //     child: const Text(
                //       'SEND',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
