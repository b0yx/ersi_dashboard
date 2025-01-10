import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ResetPasswordController extends GetxController {

  verificationcodrpassword();
}

class ResetPasswordControllerImp extends ResetPasswordController{

  late TextEditingController email ;
  late TextEditingController phone;


  @override
  verificationcodrpassword() {

    Get.toNamed(Routes.VERIFICATIONCODEVIEW);
    //
  }


  @override
  void onInit (){
    email =TextEditingController();
    phone =TextEditingController();
    super.onInit();
  }

  @override
  void onClose(){
    email.dispose();
    phone.dispose();
    super.dispose();
  }



}

