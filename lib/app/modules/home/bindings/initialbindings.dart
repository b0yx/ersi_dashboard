import 'package:ersei/app/core/class/crud.dart';
import 'package:get/get.dart';

import '../controllers/shaerd_controller.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(SharedController());
  }

}