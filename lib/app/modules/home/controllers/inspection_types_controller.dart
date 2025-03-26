import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class InspectionTypesController extends GetxController {
  // قائمة الفحوصات المتاحة مع مساراتها
  final RxList<Map<String, dynamic>> inspectionTypes = [
    {'title': 'الفحص المعماري', 'route': Routes.ARCHITECTURAL_INSPECTION},
    {'title': 'الفحص الإنشائي', 'route': Routes.STRUCTURAL_INSPECTION},
    {'title': 'الفحص الجيوتكنيكي', 'route': Routes.GEOTECHNICAL_INSPECTION},
    {'title': 'الفحص الميكانيكي', 'route': Routes.MECHANICAL_INSPECTION},
    {'title': 'الفحص الكهربائي', 'route': Routes.ELECTRICAL_INSPECTION},
    {'title': 'الأعمال المساحية', 'route': Routes.SURVEY_WORKS},
  ].obs;

  // قائمة بالمسارات المختارة
  RxList<String> selectedRoutes = <String>[].obs;

  /// التحقق مما إذا كان الفحص محدداً
  bool isSelected(String title) {
    return selectedRoutes.contains(
        inspectionTypes.firstWhereOrNull((type) => type['title'] == title)?['route']);
  }

  /// تبديل تحديد الفحص عند النقر
  void toggleInspectionType(String title) {
    final selectedType = inspectionTypes.firstWhereOrNull((type) => type['title'] == title);
    if (selectedType == null) return;

    final route = selectedType['route'] as String;
    if (selectedRoutes.contains(route)) {
      selectedRoutes.remove(route);
    } else {
      selectedRoutes.add(route);
    }
  }

  /// تحديد نوع الفحص بناءً على الاختيارات
  String getInspectionCategory() {
    if (selectedRoutes.isEmpty) return "غير محدد";
    if (selectedRoutes.length == 1) return "فحص مخصص";
    if (selectedRoutes.length == inspectionTypes.length) return "فحص شامل";
    return "فحص جزئي";
  }

  /// بدء التنقل إلى أول صفحة فحص مختارة
  void startNavigation() {
    if (selectedRoutes.isEmpty) {
      Get.snackbar("تنبيه", "يرجى اختيار فحص واحد على الأقل.");
      return;
    }

    // تحديد نوع الفحص بناءً على الاختيارات
    final String inspectionCategory = getInspectionCategory();

    // إنشاء نسخة من الفحوصات المختارة بحيث لا يتم التعديل على القائمة الأصلية
    final List<String> remainingPages = List<String>.from(selectedRoutes);

    // الانتقال إلى أول فحص وإرسال البيانات المجمعة
    final String firstPage = remainingPages.removeAt(0);
    Get.toNamed(firstPage, arguments: {
      'remainingPages': remainingPages, // باقي الفحوصات التي سيتم الانتقال إليها لاحقًا
      'reportData': {}, // سيتم تخزين بيانات كل فحص هنا
      'inspectionCategory': inspectionCategory, // نوع الفحص (جزئي - شامل - مخصص)
      'selectedRoutes': selectedRoutes, // قائمة الفحوصات المختارة
    });
  }
}
