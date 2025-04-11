import 'package:ersei/app/core/services/services.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

abstract class HomeController extends GetxController {
  initialData();
  createProject();

}

class HomeControllerImp extends HomeController {



  MyServices myServices =Get.find();
  String? userName ;
  String? userId;
  initialData(){

    userName =myServices.sharedPreferences.getString('name');
    userId=myServices.sharedPreferences.getString('id');
    print("==================================== $userName");
    print("==================================== $userId");
  }

  createProject(){
    userName =myServices.sharedPreferences.getString('name');
    userId=myServices.sharedPreferences.getString('id');
    print("==================================== $userName");
    print("==================================== $userId");
    Get.toNamed(Routes.CREATE_PROJECT,arguments: {'name':userName,'id':userId});

  }

  @override
  void onInit() {
    initialData();
    super.onInit();
  }

}
