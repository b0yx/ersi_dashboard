
import 'package:ersei/app/core/class/statusrequest.dart';
import 'package:ersei/app/core/functions/handlingdatacontroller.dart';
import 'package:ersei/app/core/functions/showerrordialog.dart';
import 'package:ersei/app/core/functions/showsuccessdialog.dart';
import 'package:ersei/app/data/datasource/remot/auth/signup_remote.dart';
import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


abstract class SignupController extends GetxController {
  // creataccoutn();
  signup();
}

class SignupControllerImp extends SignupController{
  GlobalKey<FormState> formstate =GlobalKey<FormState>();

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  late TextEditingController confirmpassword;

   StatusRequest? statuesRequest ;


  SignupData signupData =SignupData(Get.find());

  List data = [];

  // @override
  // creataccoutn() {
  //
  //   Get.offAll(Routes.HOME);
  // }
  @override


  signup()async {

    var formdata=formstate.currentState;
    if(formdata!.validate()){
      statuesRequest = StatusRequest.loading;
      update();
      var response = await signupData.postData(name.text,phone.text,email.text,password.text);
      print("=============================================== $response");
      statuesRequest=handlingData(response);
      print("=============================================== $statuesRequest");
      if(statuesRequest == StatusRequest.success){
        if(response['stutes'] == "success"){

          Map<String, dynamic> userData = {
            "name": name.text,
            "email": email.text,
          };

          showSuccessDialog('Success', 'The account has been created successfully.' ,Routes.VERIFICATIONSIGNCODEVIEW,map: userData);
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
        else{

          Get.defaultDialog(title: "Error" ,
              middleText: "Phone Number Or Email Already Exists") ;

          statuesRequest=StatusRequest.failure;

        }
        update();

      }
      else if  (statuesRequest == StatusRequest.offlinefailure)
      {
        showErrorDialog('error', 'You are offline',StatusRequest.offlinefailure,goBackTo:Routes.WELLCOME_VIEW );
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



      }else{

        showErrorDialog('Error ', ' server try again later',StatusRequest.failure,goBackTo: Routes.WELLCOME_VIEW);

        update();


      }

    }
    // Get.delete<SinupControllerAuthImp>();
    else{
      print("Not valid");
    }
  }





  // signup() async {
  //   var formData = formstate.currentState;
  //   if (formData!.validate()) {
  //     statuesRequest = StatusRequest.loading;
  //     var response = await signupData.postData(
  //       name.text,
  //       email.text,
  //       phone.text,
  //       password.text,
  //     );
  //     print("=================controller $response");
  //
  //     if (response != null) {
  //       statuesRequest = handlingData(response);
  //
  //       print('this is from controller $response');
  //
  //       if (StatusRequest.success == statuesRequest) {
  //         if (response['status'] == 'success') {
  //           print('this is from controller success $response');
  //           data.addAll(response['data']);
  //           Get.defaultDialog(
  //             actions: [
  //               const HandlingDataView(
  //                 statusRequest: StatusRequest.success,
  //                 widget: Card(),
  //               ),
  //             ],
  //             confirm: ElevatedButton(
  //               onPressed: () {
  //                 Get.offAll(Routes.HOME);
  //               },
  //               child: const Text('go to the home page'),
  //             ),
  //           );
  //         } else {
  //           statuesRequest = StatusRequest.failure;
  //         }
  //       }
  //     } else {
  //       statuesRequest = StatusRequest.serverException;
  //       Get.defaultDialog(
  //         title: 'Error serverException',
  //         middleText: 'An error occurred while connecting to the server.',
  //
  //
  //         actions: [
  //           const HandlingDataView(
  //             statusRequest: StatusRequest.failure,
  //             widget: Card(),
  //           ),
  //         ],
  //         confirm: ElevatedButton(
  //           onPressed: () {
  //             Get.toNamed(Routes.WELLCOME_VIEW);
  //           },
  //           child: const Text('server failure'),
  //         ),
  //       );
  //       print("Response is null or invalid");
  //     }
  //
  //     print('valid');
  //   } else {
  //     print('not valid');
  //   }
  // }

  // signup() async {
  //
  //   var formData =formstate.currentState;
  //   if(formData!.validate()){
  //     statuesRequest = StatusRequest.loadign;
  //     var response = await signupData.postData(
  //         name.text,
  //         password.text,
  //         email.text,
  //         phone.text);
  //     print("=================controller $response");
  //     statuesRequest =handlingData(response);
  //     if(StatusRequest.success==statuesRequest){
  //       if(response['status'] == 'success'){
  //         data.addAll(response['data']);
  //         Get.defaultDialog(
  //           actions:[const HandlingDataView(statusRequest: StatusRequest.success,
  //               widget: Card()),
  //           ],
  //           confirm: ElevatedButton(onPressed: (){
  //             Get.offAll(Routes.HOME);
  //           },
  //               child: const Text('go to the home page'))
  //         );
  //
  //
  //       }else{
  //         statuesRequest = StatusRequest.failure;
  //       }
  //     }
  //
  //     print('valid');
  //   }else{
  //     print('not valid');
  //   }
  //
  // }

  @override
  void onInit() {
    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    confirmpassword = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirmpassword.dispose();
    super.dispose();
  }

}
