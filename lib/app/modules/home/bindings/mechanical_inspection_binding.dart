import 'package:get/get.dart';
import '../controllers/mechanical_inspection_controller.dart';

class MechanicalInspectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MechanicalInspectionController>(
      () => MechanicalInspectionController(),
    );
  }
}
