import 'package:get/get.dart';
import '../controllers/geotechnical_inspection_controller.dart';

class GeotechnicalInspectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeotechnicalInspectionController>(
      () => GeotechnicalInspectionController(),
    );
  }
}
