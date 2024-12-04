import 'package:get/get.dart';
import '../controllers/inspection_types_controller.dart';

class InspectionTypesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InspectionTypesController>(
      () => InspectionTypesController(),
    );
  }
}
