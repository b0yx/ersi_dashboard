import 'package:ersei/app/core/services/services.dart';
import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/functions/handlingdatacontroller.dart';
import '../../../../core/functions/showerrordialog.dart';
import '../../../../core/functions/showsuccessdialog.dart';
import '../../../../data/datasource/remot/auth/login_remote.dart';

abstract class LoginController extends GetxController {
  login();
  forgetpassword();
}

class LoginControllerImp extends LoginController{

  GlobalKey<FormState> formstate =GlobalKey<FormState>();

  late TextEditingController email ;
  late TextEditingController password;
  late TextEditingController phone;

  StatusRequest? statuesRequest ;


  LoginData loginData =LoginData(Get.find());
  MyServices myServices =Get.find();




  @override
  forgetpassword() {

    Get.toNamed(Routes.RESETPASSWORD);
    //
  }

  @override
 login() async {
    var formdata = formstate.currentState;
    if(formdata!.validate()){
      statuesRequest = StatusRequest.loading;
      update();
      var response = await loginData.postData(phone.text,password.text);
      print("=============================================== $response");
      statuesRequest=handlingData(response);
      print("=============================================== $statuesRequest");
      if(statuesRequest == StatusRequest.success){
        if(response['stutes'] == "success"){

          myServices.sharedPreferences.setString('id', response['data'][0]['id'].toString());
          myServices.sharedPreferences.setString("name",  response['data'][0]['name']);
          myServices.sharedPreferences.setString("phone",  response['data'][0]['phone']);
          myServices.sharedPreferences.setString("email",  response['data'][0]['email']);
          myServices.sharedPreferences.setString("step", '2');
          // myServices.sharedPreferences.setString('phone',  response['data']['phone]);
          // myServices.sharedPreferences.setString('email',  response['data']['email']);


          Map<String, dynamic> userData = {

            "phone": phone.text,
            "email": email.text,
            "password": password.text,

          };

          showSuccessDialog('Success', 'Login successfully.' ,Routes.HOME,map: userData);
          // Get.defaultDialog(
          //   title: 'Successfully ',
          //               middleText: 'The account has been created successfully.',
          //
          //               actions: [
          //                 const HandlingDataView(
          //                   statusRequest: StatusRequest.success,
          //                   widget: Card(),
          //                 ),
          //
          //               ],
          //               confirm: ElevatedButton(
          //                 onPressed: () {
          //                   Get.offAll(Routes.HOME);
          //                 },
          //                 child: const Text('go to the home page'),
          //               ),
          //             );
          // update();
          // Get.to(Routes.HOME);
          update();

        }
        else{

          Get.defaultDialog(title: "Error" ,
              middleText: "Phone , Email or password  incorrect ") ;
          update();

          statuesRequest=StatusRequest.failure;

        }
        update();

      }
      else if  (statuesRequest == StatusRequest.offlinefailure)
      {
        showErrorDialog('error', 'You are offline',StatusRequest.offlinefailure,goBackTo:Routes.WELLCOME_VIEW );
        //
        // Get.defaultDialog(
        //             title: 'Error ',
        //             middleText: 'You are offline',
        //
        //
        //             actions: [
        //               const HandlingDataView(
        //                 statusRequest: StatusRequest.offlinefailure,
        //                 widget: Card(),
        //               ),
        //             ],
        //             confirm: ElevatedButton(
        //               onPressed: () {
        //                 Get.offAll(Routes.WELLCOME_VIEW);
        //               },
        //               child: const Text('Back'),
        //             ),
        //           );
        update();



      }else{

        showErrorDialog('Error ', ' server try again later',StatusRequest.failure,goBackTo: Routes.WELLCOME_VIEW);

        update();


      }

    }
    else {
      print('not valid');
    }
    // Get.toNamed(Routes.HOME);


  }

  @override
  void onInit (){
    email =TextEditingController();
    phone =TextEditingController();
    password =TextEditingController();
    super.onInit();
  }

  @override
  void onClose(){
    email.dispose();
    password.dispose();
    phone.dispose();
    super.dispose();
  }

}

//
// class LoginController extends GetxController {
//   // المتغيرات
//
//
//
//   final email = ''.obs; // لتخزين البريد الإلكتروني
//   final password = ''.obs; // لتخزين كلمة المرور
//   final isLoading = false.obs; // لتتبع حالة التحميل
//
//   // التحقق من صحة الإدخال
//   bool validateInputs() {
//     if (email.isEmpty || password.isEmpty) {
//       Get.snackbar('خطأ', 'يرجى إدخال البريد الإلكتروني وكلمة المرور');
//       return false;
//     }
//     if (!GetUtils.isEmail(email.value)) {
//       Get.snackbar('خطأ', 'البريد الإلكتروني غير صالح');
//       return false;
//     }
//     if (password.value.length < 6) {
//       Get.snackbar('خطأ', 'كلمة المرور يجب أن تكون أطول من 6 أحرف');
//       return false;
//     }
//     return true;
//   }
//
//   // دالة تسجيل الدخول
//   Future<void> login() async {
//     if (!validateInputs()) return;
//
//     isLoading.value = true; // بدء التحميل
//
//     try {
//       // استدعاء خدمة تسجيل الدخول
//       final success = await _authenticate(email.value, password.value);
//
//       if (success) {
//         Get.offNamed('/home'); // الانتقال إلى الصفحة الرئيسية
//         Get.snackbar('نجاح', 'تم تسجيل الدخول بنجاح');
//       } else {
//         Get.snackbar('خطأ', 'فشل تسجيل الدخول. تأكد من البيانات.');
//       }
//     } catch (e) {
//       Get.snackbar('خطأ', 'حدث خطأ غير متوقع. حاول مرة أخرى لاحقًا.');
//     } finally {
//       isLoading.value = false; // إنهاء التحميل
//     }
//   }
//
//   // دالة محاكاة للتواصل مع الخادم (يجب استبدالها باستدعاء API فعلي)
//   Future<bool> _authenticate(String email, String password) async {
//     // تشفير كلمة المرور قبل الإرسال (اختياري)
//     final encryptedPassword = _encryptPassword(password);
//
//     // محاكاة طلب API
//     await Future.delayed(Duration(seconds: 2));
//
//     // في التطبيق الفعلي، قم بإرسال `email` و `encryptedPassword` إلى الخادم
//     // وتحقق من نجاح تسجيل الدخول.
//     return email == 'user@example.com' && encryptedPassword == 'encrypted_123456';
//   }
//
//   // دالة لتشفير كلمة المرور
//   String _encryptPassword(String password) {
//     // في التطبيقات الفعلية، استبدل هذه الدالة بمكتبة تشفير مثل `crypto`
//     return 'encrypted_$password'; // محاكاة تشفير
//   }
// }
