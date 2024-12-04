import 'package:get/get.dart';

class CreateProjectController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var purposeOfInspection = ''.obs;
  var buildingType = ''.obs;

  void updateDate(DateTime date) {
    selectedDate.value = date;
  }

  void updatePurpose(String purpose) {
    purposeOfInspection.value = purpose;
  }

  void updateBuildingType(String type) {
    buildingType.value = type;
  }
}
