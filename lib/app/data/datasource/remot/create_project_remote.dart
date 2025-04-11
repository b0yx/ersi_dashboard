import 'package:ersei/app/applinks.dart';
import 'package:ersei/app/core/class/crud.dart';

class CreateProjectData {
  Crud crud;
  CreateProjectData(this.crud);

  postData(String projectName,String projectReportOwner ,String phone, String buildingType, String selectedPurposeForInspection, String userId ) async {
    var response = await crud.postData(AppLink.createProject, {
      "projectName": projectName,
      "projectReportOwner": projectReportOwner,
      "phone": phone,
      "buildingType": buildingType,
      "selectedPurposeForInspection": selectedPurposeForInspection,
      "userId": userId
    });
    return response.fold((l) => l, (r) => r);
  }
}