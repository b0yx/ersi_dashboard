import 'package:get/get.dart';

class InspectionTypesController extends GetxController {
  final selectedTypes = <String>[].obs;

  void toggleInspectionType(String type) {
    if (selectedTypes.contains(type)) {
      selectedTypes.remove(type);
    } else {
      selectedTypes.add(type);
    }
  }

  bool isSelected(String type) {
    return selectedTypes.contains(type);
  }
}
