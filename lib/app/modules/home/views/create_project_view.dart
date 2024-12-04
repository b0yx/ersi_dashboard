import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/create_project_controller.dart';

class CreateProjectView extends GetView<CreateProjectController> {
  const CreateProjectView({Key? key}) : super(key: key);

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
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.black54,
                  ),
                  const Expanded(
                    child: Center(
                      child: Image(
                        image: AssetImage('images/ers.eilogo.png'),
                        height: 60,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // To balance the back button
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'إنشاء مشروع',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'اسم المشروع',
                  hintStyle: const TextStyle(color: Colors.black38),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'اسم جهة استلام التقرير',
                  hintStyle: const TextStyle(color: Colors.black38),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'رقم الهاتف',
                  hintStyle: const TextStyle(color: Colors.black38),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null) {
                    controller.updateDate(picked);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Color(0xFF96E6B3),
                      ),
                      const Spacer(),
                      Obx(() => Text(
                        '${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Text(
                    'الغرض من الفحص',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF96E6B3),
                  ),
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        color: Colors.white,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              title: const Text('فحص سلامة المبنى'),
                              onTap: () {
                                controller.updatePurpose('فحص سلامة المبنى');
                                Get.back();
                              },
                            ),
                            ListTile(
                              title: const Text('فحص الصيانة الدورية'),
                              onTap: () {
                                controller.updatePurpose('فحص الصيانة الدورية');
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Text(
                    'نوع المنشأة',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF96E6B3),
                  ),
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        color: Colors.white,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              title: const Text('سكني'),
                              onTap: () {
                                controller.updateBuildingType('سكني');
                                Get.back();
                              },
                            ),
                            ListTile(
                              title: const Text('تجاري'),
                              onTap: () {
                                controller.updateBuildingType('تجاري');
                                Get.back();
                              },
                            ),
                            ListTile(
                              title: const Text('صناعي'),
                              onTap: () {
                                controller.updateBuildingType('صناعي');
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF96E6B3),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
