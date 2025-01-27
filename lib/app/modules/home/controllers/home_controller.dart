import 'package:ersei/app/core/services/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

}

class HomeControllerImp extends HomeController {

  MyServices myServices =Get.find();
  String? userName ;
  initialData(){

    userName =myServices.sharedPreferences.getString('name');

  }

  @override
  void onInit() {
    initialData();
    super.onInit();
  }

}
