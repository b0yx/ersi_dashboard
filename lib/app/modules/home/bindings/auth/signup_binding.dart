import 'package:get/get.dart';
import '../../controllers/auth/signup_controller.dart';

class SignupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupControllerImp>(
          () => SignupControllerImp(),
    );
  }
}
