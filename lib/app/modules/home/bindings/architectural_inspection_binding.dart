import 'package:get/get.dart';
import '../controllers/architectural_inspection_controller.dart';

class ArchitecturalInspectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArchitecturalInspectionController>(
      () => ArchitecturalInspectionController(),
    );
  }
}
