import 'package:get/get.dart';

class LoginViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginViewBindings>(
          () => LoginViewBindings(),
    );
  }
}
