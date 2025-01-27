import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../class/handlingdataview.dart';
import '../class/statusrequest.dart';

void showSuccessDialog(String title,String middleText,routesP, { Map? map}) {
  Get.defaultDialog(
    title: title,
    middleText: middleText,
    actions: [
      const HandlingDataView(
        statusRequest: StatusRequest.success,
        widget: Card(),
      ),
    ],
  );

  // الانتقال بعد 3 ثوانٍ إلى الصفحة الرئيسية
  Future.delayed(const Duration(seconds: 2), () {
    print('before send map $map');
    Get.offNamed(routesP , arguments: map);
    print('after send map $map');

  });
}