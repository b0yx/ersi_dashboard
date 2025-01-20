import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ResetPasswordController extends GetxController {

  verificationcodrpassword();
  resetPassword();
}

class ResetPasswordControllerImp extends ResetPasswordController{

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email ;
  late TextEditingController phone;


  @override
  verificationcodrpassword() {

    Get.toNamed(Routes.VERIFICATIONCODEVIEW);
    //
  }

  @override
  resetPassword(){
    var formData = formstate.currentState;
    if(formData!.validate()){
      print('valid');
    }else{
      print('not valid');
    }
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

