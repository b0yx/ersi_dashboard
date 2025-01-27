// import 'package:ersei/app/core/functions/showsuccessdialog.dart';
// import 'package:ersei/app/data/datasource/remot/auth/verification_signup_remote.dart';
// import 'package:ersei/app/routes/app_pages.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../core/class/statusrequest.dart';
// import '../../../../core/functions/handlingdatacontroller.dart';
// import '../../../../core/functions/showerrordialog.dart';
//
// abstract class VerificationCodeSignupController extends GetxController {
//
//   checkVerificationCode(verificationCode);
// }
//
// class VerificationCodeSignupControllerImp extends VerificationCodeSignupController {
//   GlobalKey<FormState> formstate = GlobalKey<FormState>();
//
//   String? email;
//   StatusRequest? statuesRequest;
//
//   VerificationSignupData verificationSignupData = VerificationSignupData(Get.find());
//
//
//   // checkVerificationCode(verificationCode) async {
//   //   if (email == null) {
//   //     Get.snackbar('Error', 'Email is not initialized');
//   //     return;
//   //   }
//   //
//   //   if (formstate.currentState == null || !formstate.currentState!.validate()) {
//   //     print("Form is not valid");
//   //     return;
//   //   }
//   //
//   //   statuesRequest = StatusRequest.loading;
//   //   update();
//   //   var response = await verificationSignupData.postData(verificationCode, email!);
//   //   print("=============================================== $response");
//   //   print('this is email from controller verify $email');
//   //   statuesRequest = handlingData(response);
//   //   print("=============================================== $statuesRequest");
//   //   if (statuesRequest == StatusRequest.success) {
//   //     if (response['stutes'] == "success") {
//   //       showSuccessDialog('Success', 'Account activated successfully', Routes.HOME);
//   //       update();
//   //     } else {
//   //       showErrorDialog('error', 'Invalid verification code', StatusRequest.erorr);
//   //       statuesRequest = StatusRequest.failure;
//   //     }
//   //     update();
//   //   } else if (statuesRequest == StatusRequest.offlinefailure) {
//   //     showErrorDialog('error', 'You are offline', StatusRequest.offlinefailure, goBackTo: Routes.WELLCOME_VIEW);
//   //     update();
//   //   } else {
//   //     showErrorDialog('Error', 'Server failure, try again later', StatusRequest.failure, goBackTo: Routes.WELLCOME_VIEW);
//   //     update();
//   //   }
//   // }
//
//   @override
//   void onInit() {
//     if (Get.arguments == null || Get.arguments['email'] == null) {
//       Get.snackbar('Error', 'Email is required');
//       Get.offNamed(Routes.WELLCOME_VIEW); // العودة إلى الصفحة السابقة
//     } else {
//       email = Get.arguments['email'];
//     }
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     if (statuesRequest != null) {
//       statuesRequest = null;
//     }
//     super.dispose();
//   }
//   @override
//   checkVerificationCode(verificationCode) async {
//     if (email == null) {
//       Get.snackbar('Error', 'Email is not initialized');
//       return;
//     }
//
//     if (formstate.currentState == null || !formstate.currentState!.validate()) {
//       print("Form is not valid");
//       return;
//     }
//
//     print('aliali');
//
//     statuesRequest = StatusRequest.loading;
//     update();
//     var response = await verificationSignupData.postData(verificationCode, email!);
//     print("=============================================== $response");
//     print('this is email from controller verify $email');
//     statuesRequest = handlingData(response);
//     print("=============================================== $statuesRequest");
//     if (statuesRequest == StatusRequest.success) {
//       if (response['stutes'] == "success") {
//         // الانتقال إلى الصفحة الرئيسية مباشرة
//         Get.offAllNamed(Routes.HOME); // الانتقال إلى الصفحة الرئيسية وإغلاق جميع الصفحات السابقة
//       } else {
//         // عرض رسالة خطأ إذا كان الرمز غير صحيح
//         showErrorDialog('Error', 'Invalid verification code', StatusRequest.erorr);
//         statuesRequest = StatusRequest.failure;
//       }
//       update();
//     } else if (statuesRequest == StatusRequest.offlinefailure) {
//       showErrorDialog('Error', 'You are offline', StatusRequest.offlinefailure, goBackTo: Routes.WELLCOME_VIEW);
//       update();
//     } else {
//       showErrorDialog('Error', 'Server failure, try again later', StatusRequest.failure, goBackTo: Routes.WELLCOME_VIEW);
//       update();
//     }
//   }
//
// }

// class VerificationCodeSignupControllerImp extends VerificationCodeSignupController{
//
//   GlobalKey<FormState> formstate =GlobalKey<FormState>();
//
//    String? email;
//   // late String verifycode;
//   // late TextEditingController phone;
//
//   StatusRequest? statuesRequest ;
//
//
//   VerificationSignupData verificationSignupData =VerificationSignupData(Get.find());
//
//   @override
//   checkVerificationCode(verificationCode)async {
//
//     // if (email.isEmpty) {
//     //   print("Error from line 42 : Email is null or empty.");
//     //   Get.defaultDialog(
//     //     title: "Error",
//     //     middleText: "Email not found. Please try again.",
//     //   );
//     //   return;
//     // }
//
//     var formdata=formstate.currentState;
//     if(formdata!.validate()){
//       statuesRequest = StatusRequest.loading;
//       update();
//       var response = await verificationSignupData.postData(verificationCode,email!);
//       print("=============================================== $response");
//       print('this is email from controller verifiy$email');
//       statuesRequest=handlingData(response);
//       print("=============================================== $statuesRequest");
//       if(statuesRequest == StatusRequest.success){
//         if(response['stutes'] == "success"){
//           showSuccessDialog('Success', 'Account activated successfully', Routes.HOME);
//           update();
//
//         }
//         else{
//
//           // Get.defaultDialog(title: "Error" ,
//           //     middleText: "Phone Number Or Email Already Exists") ;
//
//           showErrorDialog('error', 'Invalid verification code', StatusRequest.erorr);
//
//           statuesRequest=StatusRequest.failure;
//
//         }
//         update();
//
//       }
//       else if  (statuesRequest == StatusRequest.offlinefailure)
//       {
//         showErrorDialog('error', 'You are offline',StatusRequest.offlinefailure,goBackTo:Routes.WELLCOME_VIEW );
//         update();
//       }else{
//         showErrorDialog('Error ', ' server failure try again later',StatusRequest.failure,goBackTo: Routes.WELLCOME_VIEW);
//         update();
//       }
//
//     }
//     // Get.delete<SinupControllerAuthImp>();
//     else{
//       print("Not valid");
//     }
//   }
//
//
//   @override
//   void onInit() {
//     email = Get.arguments['email'];
//
//     super.onInit();
//   }
//
//
//   // @override
//   // void onInit() {
//   //   email = Get.arguments['email'];
//   //   super.onInit();
//   // }
//
//   @override
//   void onClose() {
//     if (statuesRequest != null) {
//       statuesRequest = null;
//     }
//     super.dispose();
//   }
//
//
//   // @override
//   // void onClose(){
//   //
//   //   super.dispose();
//   // }
//
//
//
// }

import 'package:ersei/app/data/datasource/remot/auth/verification_signup_remote.dart';
import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/class/statusrequest.dart';
import '../../../../core/functions/handlingdatacontroller.dart';
import '../../../../core/functions/showerrordialog.dart';
import '../../../../core/functions/showsuccessdialog.dart';

abstract class VerificationCodeSignupController extends GetxController {
  Future<void> checkVerificationCode(String verificationCode);
}

class VerificationCodeSignupControllerImp extends VerificationCodeSignupController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  String? email;
  StatusRequest? statuesRequest;

  VerificationSignupData verificationSignupData = VerificationSignupData(Get.find());

  @override
  Future<void> checkVerificationCode(String verificationCode) async {
    if (email == null || email!.isEmpty) {
      showErrorDialog(
        'Error',
        'Email not found. Please try again.',
        StatusRequest.failure,
      );
      return;
    }

    statuesRequest = StatusRequest.loading;
    update();

    var response = await verificationSignupData.postData(email!,verificationCode );
    print("Response: $response");

    statuesRequest = handlingData(response);

    if (statuesRequest == StatusRequest.success) {
      if (response['stutes'] == "success") {
        showSuccessDialog('Success', 'Account activated successfully', Routes.LOGINVIEW);
      } else {
        showErrorDialog('Error', 'Invalid verification code', StatusRequest.erorr);
      }
    } else if (statuesRequest == StatusRequest.offlinefailure) {
      showErrorDialog('Error', 'You are offline', StatusRequest.offlinefailure, goBackTo: Routes.WELLCOME_VIEW);
    } else {
      showErrorDialog('Error', 'Server failure. Try again later.', StatusRequest.failure, goBackTo: Routes.WELLCOME_VIEW);
    }

    update();
  }

  @override
  void onInit() {
    email = Get.arguments?['email'];
    super.onInit();
  }
}


