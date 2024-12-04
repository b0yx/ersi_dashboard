import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F9F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'images/ers.eilogo.png',
                  height: 60,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'مرحبا بعودتك اسماعيل',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(
                    Icons.history,
                    color: Color(0xFF96E6B3),
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'التقارير الأخيرة',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: List.generate(
                    5,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'images/engineerphoto.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          index % 2 == 0
                              ? 'مبنى وزارة المالية'
                              : 'مبنى المدينة للطيران',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          index % 2 == 0 ? 'فحص تفصيلي' : 'فحص جزئي',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () => Get.toNamed(Routes.CREATE_PROJECT),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFF96E6B3),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'اضافة تقرير فحص جديد',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.CREATE_PROJECT),
        backgroundColor: const Color(0xFF96E6B3),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
