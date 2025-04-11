import 'package:ersei/app/core/class/statusrequest.dart';
import 'package:ersei/app/core/functions/handlingdatacontroller.dart';
import 'package:ersei/app/core/functions/showerrordialog.dart';
import 'package:ersei/app/core/functions/showsuccessdialog.dart';
import 'package:ersei/app/data/datasource/remot/create_project_remote.dart';
import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/services.dart';

abstract class CreateProjectController extends GetxController {
  createProject();
  initialData();
}

class CreateProjectControllerImp extends CreateProjectController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController projectName;
  late TextEditingController projectReportOwner;
  late TextEditingController phone;
  var selectedBuildingType = 'خاصة'.obs;
  var selectedPurposeForInspection = 'فحص الصيانة الدورية'.obs;


  MyServices myServices =Get.find();
  var arguments = Get.arguments;
  String? userName = Get.arguments['name'];
  String? userId = Get.arguments['id'];
  initialData(){

    userName =myServices.sharedPreferences.getString('name');
    userId=myServices.sharedPreferences.getString('id');
    print("==============create project page ====================== $userName");
    print("==============create project page====================== $userId");

  }

  void updateBuildingType(String newValue) {
    selectedBuildingType.value = newValue;
    print(selectedBuildingType.value);
  }

  void updatePurposeForInspection(String newValue) {
    selectedPurposeForInspection.value = newValue;
    print(selectedPurposeForInspection.value);
  }

  StatusRequest? statuesRequest;

  CreateProjectData createProjectData = CreateProjectData(Get.find());

  @override
  createProject() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      statuesRequest = StatusRequest.loading;
      update();
      var response = await createProjectData.postData(
        projectName.text,
        projectReportOwner.text,
        phone.text,
        selectedBuildingType.value,
        selectedPurposeForInspection.value,
        userId!,
      );
      print("=============================================== $response");
      statuesRequest = handlingData(response);
      print("=============================================== $statuesRequest");
      if (statuesRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          showSuccessDialog('Success', 'Project created successfully.', Routes.INSPECTION_TYPES);
          update();
        } else {
          Get.defaultDialog(title: "Error", middleText: "Project creation failed");
          statuesRequest = StatusRequest.failure;
        }
        update();
      } else if (statuesRequest == StatusRequest.offlinefailure) {
        showErrorDialog('Error', 'You are offline', StatusRequest.offlinefailure, goBackTo: Routes.WELLCOME_VIEW);
        update();
      } else {
        showErrorDialog('Error', 'Server failure, try again later', StatusRequest.failure, goBackTo: Routes.WELLCOME_VIEW);
        update();
      }
    } else {
      print("Not valid");
    }
  }

  @override
  void onInit() {
    projectName = TextEditingController();
    projectReportOwner = TextEditingController();
    phone = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    projectName.dispose();
    projectReportOwner.dispose();
    phone.dispose();
    super.dispose();
  }
}