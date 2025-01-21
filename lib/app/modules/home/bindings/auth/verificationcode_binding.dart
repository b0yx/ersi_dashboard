import 'package:get/get.dart';

import '../../controllers/auth/verification_code_controller.dart';

class VerificationCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationCodeControllerImp>(
          () => VerificationCodeControllerImp(),
    );
  }
}
