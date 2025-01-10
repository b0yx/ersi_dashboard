import 'package:ersei/app/routes/app_pages.dart';
import 'package:get/get.dart';

 abstract class WellcomeViewController extends GetxController {


  login();
  letsgo();

}

class WellcomeViewControllerImp extends WellcomeViewController{
  @override
  login() {
    Get.toNamed(Routes.LOGINVIEW);
  }

  @override
  letsgo() {
    Get.toNamed(Routes.SIGNUPVIEW);
  }

}
