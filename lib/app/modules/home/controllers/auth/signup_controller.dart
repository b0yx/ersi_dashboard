import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class SinginController extends GetxController {
  creataccoutn();
}

class SinginControllerImp extends SinginController{


  late TextEditingController name;
  late TextEditingController email ;
  late TextEditingController phone;
  late TextEditingController password;
  late TextEditingController confirmpassword;



  @override
  creataccoutn() {
    Get.offAll(Routes.HOME);
  }

  // @override
  // forgetpassword() {
  //
  //   Get.toNamed(Routes.RESETPASSWORD);
  //   //
  // }
  //
  // @override
  // login() {
  //
  //   Get.toNamed(Routes.HOME);
  //
  //
  // }

  @override
  void onInit (){
    name =TextEditingController();
    email =TextEditingController();
    phone =TextEditingController();
    password =TextEditingController();
    confirmpassword =TextEditingController();
    super.onInit();
  }

  @override
  void onClose(){
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirmpassword.dispose();
    super.dispose();
  }



}
