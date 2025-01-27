import 'package:ersei/app/core/services/services.dart';
import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyMiddleWare extends GetMiddleware{

  @override
  int? get priority =>1;

  MyServices myServices =Get.find();

  RouteSettings? redirect(String? route){
    if (myServices.sharedPreferences.getString('step') =='2'){
      return const RouteSettings(name:Routes.HOME);
    }
    return null;
  }
  
}