import 'package:get/get.dart';

import '../../controllers/auth/verification_code_signup_controller.dart';

class VerificationCodeSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationCodeSignupControllerImp>(
          () => VerificationCodeSignupControllerImp(),
    );
  }
}
