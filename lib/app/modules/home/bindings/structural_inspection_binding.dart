import 'package:get/get.dart';
import '../controllers/structural_inspection_controller.dart';

class StructuralInspectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StructuralInspectionControllerImp>(
      () => StructuralInspectionControllerImp(),
    );
  }
}
