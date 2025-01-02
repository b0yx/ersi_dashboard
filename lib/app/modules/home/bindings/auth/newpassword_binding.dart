import 'package:get/get.dart';

class NewPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPasswordBindings>(
          () => NewPasswordBindings(),
    );
  }
}
