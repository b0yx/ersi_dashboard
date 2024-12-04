import 'package:get/get.dart';
import '../controllers/survey_works_controller.dart';

class SurveyWorksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyWorksController>(
      () => SurveyWorksController(),
    );
  }
}
