import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controllers/shaerd_controller.dart';

class SharedBinding extends Bindings {
  @override
  void dependencies() {
    // تسجيل الكنترولر المشترك بحيث يكون متاحاً لجميع الصفحات
    Get.lazyPut<SharedController>(
          () => SharedController(),
    );
  }
}