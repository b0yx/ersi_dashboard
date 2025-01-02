import 'package:get/get.dart';

class VerificationCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationCodeBinding>(
          () => VerificationCodeBinding(),
    );
  }
}
