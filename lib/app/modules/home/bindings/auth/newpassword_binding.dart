import 'package:get/get.dart';

import '../../controllers/auth/new_password_controller.dart';

class NewPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPasswordControllerImp>(
          () => NewPasswordControllerImp(),
    );
  }
}
