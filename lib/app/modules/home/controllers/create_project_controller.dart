import 'package:get/get.dart';

class CreateProjectController extends GetxController {

}
class CreateProjectControllerImp extends CreateProjectController{

  var selectedDate = DateTime.now();
  var purposeOfInspection = '';
  var buildingType = '';

  void updateDate(DateTime date) {
    selectedDate = date;
  }

  void updatePurpose(String purpose) {
    purposeOfInspection = purpose;
  }

  void updateBuildingType(String type) {
    buildingType = type;
  }

}
