
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertexit(){
   Get.defaultDialog(
    title: 'تنبيه',
      middleText: 'هل تريد الخروج',
        cancel: ElevatedButton(

          // icon: Icons.cancel,
          //   label: 'cancel',
          //   backgroundColor: ColorsApp.greencolorapp,
          //   textColor: Colors.white,
            onPressed:() => Get.back(),
          child:const Text('No'),
        ),
    confirm: ElevatedButton(

      // icon: Icons.cancel,
      //   label: 'cancel',
      //   backgroundColor: ColorsApp.greencolorapp,
      //   textColor: Colors.white,
      onPressed:() => exit(0),
      child:const Text('Yes'),
    ),
  );
   return Future.value(true);
}