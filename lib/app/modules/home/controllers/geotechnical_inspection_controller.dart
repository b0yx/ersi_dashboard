import 'package:get/get.dart';

class GeotechnicalInspectionController extends GetxController {
  // Observable variables for checkboxes
  final soilReportStudied = false.obs;
  final addSoilReport = false.obs;
  
  // Observable variable for report compliance
  final reportCompliance = Rxn<String>();
  
  // Observable list for soil report images
  final soilReportImages = <String>[].obs;
  
  void addSoilReportImage(String imagePath) {
    soilReportImages.add(imagePath);
  }
  
  void setReportCompliance(String value) {
    reportCompliance.value = value;
  }
  
  Map<String, dynamic> getFormData() {
    return {
      'soilReportStudied': soilReportStudied.value,
      'addSoilReport': addSoilReport.value,
      'reportCompliance': reportCompliance.value,
      'soilReportImages': soilReportImages,
    };
  }
}
