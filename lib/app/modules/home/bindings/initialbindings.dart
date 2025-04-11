import 'package:ersei/app/core/class/crud.dart';
import 'package:get/get.dart';

import '../../../core/class/crudjson.dart';
import '../controllers/shaerd_controller.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(CrudJson());
    Get.put(SharedController());
  }

}