import 'package:ersei/app/modules/home/views/widget/customelevetbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ersei/app/core/constant/colors.dart';

import '../../../../core/class/statusrequest.dart';
import '../../controllers/report_success_controller.dart';

class ReportSuccessView extends GetView<ReportSuccessController> {
  const ReportSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // Logo
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/ers.eilogo.png',
                      height: 40,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 40,
                          width: 40,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              const Spacer(),
              // Success Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF96E6B3),
                          width: 2,
                        ),
                      ),
                      child: const Text(
                        '!تم انشاء التقرير بنجاح',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF96E6B3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'رابط التقرير',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            label: 'مشاركة',
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            onPressed: () {
                              // مشاركة الرابط (يمكن تنفيذ الكود المناسب هنا)
                            },
                            icon: Icons.share,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(() {
                            if (controller.statusRequest.value ==
                                StatusRequest.loading) {
                              return Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: const CircularProgressIndicator(),
                              );
                            } else {
                              return CustomElevatedButton(
                                label: 'حفظ التقرير',
                                backgroundColor: ColorsApp.greencolorapp,
                                textColor: Colors.white,
                                onPressed: () {
                                  controller.sendReport();
                                },
                                icon: Icons.save,
                              );
                            }
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Home Button
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  label: 'الصفحة الرئيسية',
                  backgroundColor: ColorsApp.greencolorapp,
                  textColor: Colors.white,
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
