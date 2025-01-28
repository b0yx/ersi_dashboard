import 'package:get/get.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class InspectionTypesController extends GetxController {
  final RxList<Map<String, dynamic>> inspectionTypes = [
    {
      'title': 'الفحص المعماري',
      'imagePath': 'images/test_image.jpg',
      'details': [
        'Study of architectural plans',
        'Architectural finishes inspection and study',
        'Overall evaluation of the architectural examination',
        'General Notes',
      ],
      'route': Routes.ARCHITECTURAL_INSPECTION,
    },
    {
      'title': 'الفحص الإنشائي',
      'imagePath': 'images/test_image.jpg',
      'details': [],
      'route': Routes.STRUCTURAL_INSPECTION,
    },
    {
      'title': 'الفحص الجيوتكنيكي',
      'imagePath': 'images/test_image.jpg',
      'details': [],
      'route': Routes.GEOTECHNICAL_INSPECTION,
    },
    {
      'title': 'الفحص الميكانيكي',
      'imagePath': 'images/test_image.jpg',
      'details': [],
      'route': Routes.MECHANICAL_INSPECTION,
    },
    {
      'title': 'الفحص الكهربائي',
      'imagePath': 'images/test_image.jpg',
      'details': [],
      'route': Routes.ELECTRICAL_INSPECTION,
    },
    {
      'title': 'الأعمال المساحية',
      'imagePath': 'images/test_image.jpg',
      'details': [],
      'route': Routes.SURVEY_WORKS,
    },
  ].obs;

  RxList<String> selectedInspections = <String>[].obs;

  // تحديد إذا كان الخيار محددًا
  bool isSelected(String title) => selectedInspections.contains(title);

  // تبديل حالة التحديد
  void toggleInspectionType(String title) {
    if (selectedInspections.contains(title)) {
      selectedInspections.remove(title);
    } else {
      selectedInspections.add(title);
    }
  }

  // تنفيذ التوجيه إلى الصفحات المختارة
  void navigateToSelectedPages() async {
    for (var inspection in selectedInspections) {
      final route = inspectionTypes.firstWhere(
              (type) => type['title'] == inspection)['route'];
      if (route != null) {
        await Get.toNamed(route);
      }
    }
  }
}
