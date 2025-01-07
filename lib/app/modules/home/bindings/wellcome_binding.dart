import 'package:get/get.dart';
import '../controllers/wellcomview_controller.dart';

class WellcomeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WellcomeViewControllerImp>(
          () => WellcomeViewControllerImp(),
    );
  }
}
