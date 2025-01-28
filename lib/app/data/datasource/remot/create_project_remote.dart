import 'package:ersei/app/applinks.dart';
import 'package:ersei/app/core/class/crud.dart';

class CreateProjectData {
  Crud crud;
  CreateProjectData(this.crud);

  postData(String projectName, String purpose, String buildingType, DateTime date) async {
    var response = await crud.postData(AppLink.createProject, {
      'projectName': projectName,
      'purpose': purpose,
      'buildingType': buildingType,
      'date': date.toIso8601String(),
    });
    return response.fold((l) => l, (r) => r);
  }
}