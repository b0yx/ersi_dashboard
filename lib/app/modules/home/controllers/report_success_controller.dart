import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:ersei/app/core/class/statusrequest.dart';
import 'package:ersei/app/core/functions/handlingdatacontroller.dart';
import 'package:ersei/app/core/functions/showerrordialog.dart';
import 'package:ersei/app/core/functions/showsuccessdialog.dart';
import 'package:ersei/app/data/datasource/remot/report_remote.dart';
import 'package:ersei/app/routes/app_pages.dart';

class ReportSuccessController extends GetxController {
  final RxMap<String, dynamic> reportData = RxMap<String, dynamic>();
  final RxString inspectionCategory = ''.obs;
  final Rx<StatusRequest> statusRequest = StatusRequest.none.obs; // متغير تفاعلي لحالة الطلب

  /// دالة لإرسال التقرير إلى السيرفر
  Future<void> sendReport() async {
    // التأكد من تعبئة البيانات قبل الإرسال
    if (reportData.isEmpty || inspectionCategory.value.isEmpty) {
      print("Report data or inspection category not set yet");
      showErrorDialog(
        'Error',
        'All fields must be filled in.',
        StatusRequest.failure,
        goBackTo: Routes.REPORT_SUCCESS,
      );
      return;
    }

    statusRequest.value = StatusRequest.loading; // تعيين الحالة إلى "loading"
    update();

    // تجهيز البيانات للإرسال: تحويل reportData إلى JSON وإضافة فئة الفحص
    Map<String, dynamic> dataToSend = {
      'reportData': jsonEncode(Map<String, dynamic>.from(reportData)),
      'inspectionCategory': inspectionCategory.value,
    };

    // إنشاء كائن من SendReportData باستخدام Get.find() لتمرير الاعتماديات
    SendReportData sendReportData = SendReportData(Get.find());
    var response = await sendReportData.postData(dataToSend);

    print("=============================================== Response: $response");
    statusRequest.value = handlingData(response);
    print("=============================================== statusRequest: ${statusRequest.value}");

    // التعامل مع الاستجابة وفق حالة الطلب
    if (statusRequest.value == StatusRequest.success) {
      if (response['status'] == "success") {
        showSuccessDialog(
          'Success',
          'Report submitted successfully.',
          Routes.INSPECTION_TYPES,
        );
      } else {
        Get.defaultDialog(title: "Error", middleText: "Report submission failed");
        statusRequest.value = StatusRequest.failure;
      }
    } else if (statusRequest.value == StatusRequest.offlinefailure) {
      showErrorDialog(
        'Error',
        'You are offline',
        StatusRequest.offlinefailure,
        goBackTo: Routes.WELLCOME_VIEW,
      );
    } else {
      showErrorDialog(
        'Error',
        'Server failure, try again later',
        StatusRequest.failure,
        goBackTo: Routes.WELLCOME_VIEW,
      );
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();

    // استقبال البيانات من الصفحة السابقة باستخدام Get.arguments
    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      if (args['reportData'] != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          reportData.assignAll(args['reportData']);
          print("Collected report data:");
          reportData.forEach((key, value) {
            print("$key: $value");
          });
        });
      }
      if (args['inspectionCategory'] != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          inspectionCategory.value = args['inspectionCategory'];
          print("Inspection Category: ${inspectionCategory.value}");
        });
      }
    }
  }
}
