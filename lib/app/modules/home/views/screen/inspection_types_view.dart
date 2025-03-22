
import 'package:ersei/app/core/constant/imagesassets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/inspection_types_controller.dart';

class InspectionTypesView extends GetView<InspectionTypesController> {
  const InspectionTypesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.black54),
            onPressed: () => Get.offAllNamed('/home'),
          ),
        ],
        title: const Text(
          "أنواع الفحص",
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.inspectionTypes.length,
                itemBuilder: (context, index) {
                  final type = controller.inspectionTypes[index];
                  final title = type['title'] as String;
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                      ImageAssets.applogo,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Obx(() => Icon(
                        controller.isSelected(title)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: controller.isSelected(title) ? Colors.green : Colors.grey,
                      )),
                      onTap: () {
                        controller.toggleInspectionType(title);
                      },
                    ),
                  );
                },
              ),
            ),
            Obx(() => Text(
              "نوع الفحص: ${controller.getInspectionCategory()}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.startNavigation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
              ),
              child: const Text("التالي", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}