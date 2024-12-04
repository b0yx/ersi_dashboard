import 'package:get/get.dart';

class StructuralInspectionController extends GetxController {
  var matchingPercentage = 0.0.obs;
  
  // Observable lists for images
  final planImages = <String>[].obs;
  final executedImages = <String>[].obs;
  
  // Observable maps for test results
  final concreteTests = <String, Map<String, double>>{}.obs;
  final reinforcementTests = <String, bool>{}.obs;
  final verticalAlignmentTests = <String, bool>{}.obs;
  final axisTests = <String, bool>{}.obs;
  final grooveTests = <String, bool>{}.obs;
  
  void addPlanImage(String imagePath) {
    planImages.add(imagePath);
  }
  
  void addExecutedImage(String imagePath) {
    executedImages.add(imagePath);
  }
  
  void setConcreteTest(String section, double hammerReading, double concreteStrength) {
    concreteTests[section] = {
      'hammerReading': hammerReading,
      'concreteStrength': concreteStrength,
    };
  }
  
  void setReinforcementTest(String section, bool isMatching) {
    reinforcementTests[section] = isMatching;
  }
  
  void setVerticalAlignmentTest(String section, bool isMatching) {
    verticalAlignmentTests[section] = isMatching;
  }
  
  void setAxisTest(String section, bool isMatching) {
    axisTests[section] = isMatching;
  }
  
  void setGrooveTest(String section, bool isMatching) {
    grooveTests[section] = isMatching;
  }
  
  Map<String, dynamic> getFormData() {
    return {
      'matchingPercentage': matchingPercentage.value,
      'planImages': planImages,
      'executedImages': executedImages,
      'concreteTests': concreteTests,
      'reinforcementTests': reinforcementTests,
      'verticalAlignmentTests': verticalAlignmentTests,
      'axisTests': axisTests,
      'grooveTests': grooveTests,
    };
  }
}
