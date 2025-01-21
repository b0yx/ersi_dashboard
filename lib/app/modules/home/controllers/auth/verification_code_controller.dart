import 'package:ersei/app/routes/app_pages.dart';
import 'package:get/get.dart';

abstract class VerificationCodeController extends GetxController {

  checkverfiycode();
}

class VerificationCodeControllerImp extends VerificationCodeController{

  late String verificationCode;
  // late TextEditingController phone;


  @override
  checkverfiycode() {
    Get.toNamed(Routes.NEWPASSWORD);
  }



  @override
  void onClose(){

    super.dispose();
  }



}

