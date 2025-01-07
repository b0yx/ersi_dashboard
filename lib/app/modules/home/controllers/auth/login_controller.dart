import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login();
  forgetpassword();
}

class LoginControllerImp extends LoginController{

  late TextEditingController email ;
  late TextEditingController password;


  @override
  forgetpassword() {

    Get.toNamed(Routes.RESETPASSWORD);
    //
  }

  @override
  login() {

    Get.toNamed(Routes.HOME);


  }

  @override
  void onInit (){
    email =TextEditingController();
    password =TextEditingController();
    super.onInit();
  }

  @override
  void onClose(){
    email.dispose();
    password.dispose();
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
