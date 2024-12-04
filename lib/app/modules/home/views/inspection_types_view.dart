import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inspection_types_controller.dart';
import '../../../routes/app_pages.dart';

class InspectionTypesView extends GetView<InspectionTypesController> {
  const InspectionTypesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F9F4),
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
          'الفحص الجزئي',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildInspectionType(
                'الفحص المعماري',
                'images/test_image.jpg',
                [
                  'Study of architectural plans',
                  'Architectural finishes inspection and study',
                  'Overall evaluation of the architectural examination',
                  'General Notes',
                ],
              ),
              const SizedBox(height: 15),
              _buildInspectionType(
                'الفحص الإنشائي',
                'images/test_image.jpg',
                [],
              ),
              const SizedBox(height: 15),
              _buildInspectionType(
                'الفحص الجيوتكنيكي',
                'images/test_image.jpg',
                [],
              ),
              const SizedBox(height: 15),
              _buildInspectionType(
                'الفحص الميكانيكي',
                'images/test_image.jpg',
                [],
              ),
              const SizedBox(height: 15),
              _buildInspectionType(
                'الفحص الكهربائي',
                'images/test_image.jpg',
                [],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to next page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF96E6B3),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
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

  Widget _buildInspectionType(
      String title, String imagePath, List<String> details) {
    return Obx(() {
      final isSelected = controller.isSelected(title);
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(Get.context!).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            leading: Image.asset(
              imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(
              title,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF96E6B3),
                  width: 2,
                ),
                color: isSelected ? const Color(0xFF96E6B3) : Colors.white,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
            children: [
              if (details.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: details
                        .map((detail) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                detail,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
            ],
            onExpansionChanged: (expanded) {
              if (expanded) {
                controller.toggleInspectionType(title);
                if (title == 'الفحص المعماري') {
                  Get.toNamed(Routes.ARCHITECTURAL_INSPECTION);
                } else if (title == 'الفحص الإنشائي') {
                  Get.toNamed(Routes.STRUCTURAL_INSPECTION);
                } else if (title == 'الفحص الجيوتكنيكي') {
                  Get.toNamed(Routes.GEOTECHNICAL_INSPECTION);
                }
              }
            },
          ),
        ),
      );
    });
  }
}
