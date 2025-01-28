import 'package:ersei/app/core/class/statusrequest.dart';
import 'package:ersei/app/core/functions/handlingdatacontroller.dart';
import 'package:ersei/app/core/functions/showerrordialog.dart';
import 'package:ersei/app/core/functions/showsuccessdialog.dart';
import 'package:ersei/app/data/datasource/remot/create_project_remote.dart';
import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CreateProjectController extends GetxController {
  createProject();
}

class CreateProjectControllerImp extends CreateProjectController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController projectName;
  late TextEditingController purpose;
  var selectedBuildingType = 'Residential'.obs;
  var selectedDate = DateTime.now();

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
        purpose.text,
        selectedBuildingType.value,
        selectedDate,
      );
      print("=============================================== $response");
      statuesRequest = handlingData(response);
      print("=============================================== $statuesRequest");
      if (statuesRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          showSuccessDialog('Success', 'Project created successfully.', Routes.HOME);
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
    purpose = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    projectName.dispose();
    purpose.dispose();
    super.dispose();
  }
}