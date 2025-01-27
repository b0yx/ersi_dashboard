import 'package:ersei/app/data/datasource/remot/auth/forgetpassword/forgerpassword_remote.dart';
import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/class/statusrequest.dart';
import '../../../../core/functions/handlingdatacontroller.dart';
import '../../../../core/functions/showerrordialog.dart';
import '../../../../core/functions/showsuccessdialog.dart';

abstract class ResetPasswordController extends GetxController {

  resetPassword();
}

class ResetPasswordControllerImp extends ResetPasswordController {

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;

  late TextEditingController phone;

  CheckEmail checkEmail = CheckEmail(Get.find());

  StatusRequest? statuesRequest;



  @override
  resetPassword() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      statuesRequest = StatusRequest.loading;
      update();
      var response = await checkEmail.postData(phone.text);
      print("=============================================== $response");
      statuesRequest = handlingData(response);
      print("=============================================== $statuesRequest");
      if (statuesRequest == StatusRequest.success) {
        if (response['stutes'] == "success") {
          Map<String, dynamic> userData = {

            "phone": phone.text,


          };

          showSuccessDialog(
              'Success', 'Login successfully.', Routes.VERIFICATIONCODEVIEW, map: userData);
          // Get.defaultDialog(
          //   title: 'Successfully ',
          //               middleText: 'The account has been created successfully.',
          //
          //               actions: [
          //                 const HandlingDataView(
          //                   statusRequest: StatusRequest.success,
          //                   widget: Card(),
          //                 ),
          //
          //               ],
          //               confirm: ElevatedButton(
          //                 onPressed: () {
          //                   Get.offAll(Routes.HOME);
          //                 },
          //                 child: const Text('go to the home page'),
          //               ),
          //             );
          // update();
          // Get.to(Routes.HOME);
          update();
        }
        else {
          Get.defaultDialog(title: "Error",
              middleText: "Phone , Email or password  incorrect ");
          update();

          statuesRequest = StatusRequest.failure;
        }
        update();
      }
      else if (statuesRequest == StatusRequest.offlinefailure) {
        showErrorDialog(
            'error', 'You are offline', StatusRequest.offlinefailure,
            goBackTo: Routes.WELLCOME_VIEW);
        //
        // Get.defaultDialog(
        //             title: 'Error ',
        //             middleText: 'You are offline',
        //
        //
        //             actions: [
        //               const HandlingDataView(
        //                 statusRequest: StatusRequest.offlinefailure,
        //                 widget: Card(),
        //               ),
        //             ],
        //             confirm: ElevatedButton(
        //               onPressed: () {
        //                 Get.offAll(Routes.WELLCOME_VIEW);
        //               },
        //               child: const Text('Back'),
        //             ),
        //           );
        update();
      } else {
        showErrorDialog(
            'Error ', ' server try again later', StatusRequest.failure,
            goBackTo: Routes.WELLCOME_VIEW);

        update();
      }
    }
    else {
      print('not valid');
    }




  }
  @override
  void onInit() {
    phone = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    phone.dispose();
    super.dispose();
  }


}
