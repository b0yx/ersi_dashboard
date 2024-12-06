import 'package:get/get.dart';
import '../controllers/report_success_controller.dart';

class ReportSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportSuccessController>(
      () => ReportSuccessController(),
    );
  }
}
