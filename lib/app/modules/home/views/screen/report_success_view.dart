import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ersei/app/core/constant/colors.dart';

import '../../controllers/report_success_controller.dart';

class ReportSuccessView extends GetView<ReportSuccessController> {
  const ReportSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String inspectionCategory = Get.arguments?['inspectionCategory'] ?? "غير محدد";

    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                "✅ تم جمع البيانات بنجاح!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text("فئة الفحص: $inspectionCategory"),
              const SizedBox(height: 20),
              // يمكنك هنا عرض البيانات أو إجراء عمليات أخرى عليها
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    controller.reportData.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.offAllNamed('/home'),
                child: const Text("العودة للصفحة الرئيسية"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
