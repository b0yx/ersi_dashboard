import 'package:get/get.dart';

class ResetPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordBindings>(
          () => ResetPasswordBindings(),
    );
  }
}
