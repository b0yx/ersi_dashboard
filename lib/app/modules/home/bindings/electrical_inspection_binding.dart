import 'package:get/get.dart';
import '../controllers/electrical_inspection_controller.dart';

class ElectricalInspectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ElectricalInspectionControllerImp>(
      () => ElectricalInspectionControllerImp(),
    );
  }
}
