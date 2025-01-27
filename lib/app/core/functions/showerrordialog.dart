import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../class/handlingdataview.dart';

void showErrorDialog(String title, String message,statusrequest,{String? goBackTo}) {
  Get.defaultDialog(
    title: title,
    middleText: message,
    actions: [
       HandlingDataView(
        statusRequest: statusrequest,
        widget:const Card(),
      ),
    ],
    confirm: ElevatedButton(
      onPressed: () {
        if (goBackTo != null) {
          Get.offAllNamed(goBackTo);
        } else {
          Get.back();
        }
      },
      child: const Text('Back'),
    ),
  );
}