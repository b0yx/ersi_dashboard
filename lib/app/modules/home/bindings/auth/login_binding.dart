import 'package:get/get.dart';

import '../../controllers/auth/login_controller.dart';

class LoginViewBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginControllerImp>(
          () => LoginControllerImp(),
    );
  }
}
