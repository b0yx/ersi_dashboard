import 'package:ersei/app/routes/app_pages.dart';
import 'package:get/get.dart';

 abstract class WellcomeViewController extends GetxController {

  sigin();
  login();

}

class WellcomeViewControllerImp extends WellcomeViewController{
  @override
  sigin() {
   Get.toNamed(Routes.SIGNUPVIEW);
  }

  @override
  login() {
    Get.toNamed(Routes.LOGINVIEW);
  }

}
