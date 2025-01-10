import 'package:ersei/app/routes/app_pages.dart';
import 'package:get/get.dart';

abstract class VerificationCode extends GetxController {

  checkverfiycode();
}

class VerificationCodeControllerImp extends VerificationCode{

  // late TextEditingController email ;
  // late TextEditingController phone;


  @override
  checkverfiycode() {

    Get.toNamed(Routes.NEWPASSWORD);
    //
  }


  // @override
  // void onInit (){
  //
  //   super.onInit();
  // }
  //
  // @override
  // void onClose(){
  //
  //   super.dispose();
  // }



}

