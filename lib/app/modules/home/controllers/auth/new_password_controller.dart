import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NewPasswordController extends GetxController {

  finall();
  newPassword();
}

class NewPasswordControllerImp extends NewPasswordController{
  GlobalKey<FormState> formstate =GlobalKey<FormState>();

  late TextEditingController password;


  @override
  finall() {

    Get.toNamed(Routes.NEWPASSWORD);
    //
  }

  @override
  newPassword() {
    var formData =formstate.currentState;
    if(formData!.validate()){
      print('valid');
    }else{
      print('not valid ');
    }

  }


@override
void onInit (){

    password = TextEditingController();

  super.onInit();
}

@override
void onClose(){
  password.dispose();

  super.dispose();
}



}

