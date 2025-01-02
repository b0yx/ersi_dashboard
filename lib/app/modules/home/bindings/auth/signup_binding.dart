import 'package:get/get.dart';

class SignBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignBindings>(
          () => SignBindings(),
    );
  }
}
