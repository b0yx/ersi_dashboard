import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../core/constant/imagesassets.dart';

class InspectionTypesController extends GetxController {
  // قائمة بأنواع الفحص مع بياناتها (العنوان، صورة، والمسار)
  final RxList<Map<String, dynamic>> inspectionTypes = [
    {
      'title': 'الفحص المعماري',
      'imagePath': ImageAssets.applogo,
      'route': Routes.ARCHITECTURAL_INSPECTION,
    },
    {
      'title': 'الفحص الإنشائي',
      'imagePath': ImageAssets.applogo,
      'route': Routes.STRUCTURAL_INSPECTION,
    },
    {
      'title': 'الفحص الجيوتكنيكي',
      'imagePath': ImageAssets.applogo,
      'route': Routes.GEOTECHNICAL_INSPECTION,
    },
    {
      'title': 'الفحص الميكانيكي',
      'imagePath': ImageAssets.applogo,
      'route': Routes.MECHANICAL_INSPECTION,
    },
    {
      'title': 'الفحص الكهربائي',
      'imagePath': ImageAssets.applogo,
      'route': Routes.ELECTRICAL_INSPECTION,
    },
    {
      'title': 'الأعمال المساحية',
      'imagePath': ImageAssets.applogo,
      'route': Routes.SURVEY_WORKS,
    },
  ].obs;

  /// قائمة لتخزين العناوين المختارة (يختارها المستخدم عند الضغط)
  final RxList<String> selectedTypes = <String>[].obs;

  /// قائمة لتخزين مسارات الصفحات المختارة
  List<String> selectedRoutes = [];

  /// مؤشر للتنقل بين الصفحات المختارة
  int _currentPageIndex = 0;

  /// تبديل اختيار نوع الفحص
  void toggleInspectionType(String title) {
    if (selectedTypes.contains(title)) {
      selectedTypes.remove(title);
    } else {
      selectedTypes.add(title);
    }
  }

  /// التحقق مما إذا كان النوع مختارًا
  bool isSelected(String title) => selectedTypes.contains(title);

  /// استخراج مسارات الصفحات المختارة بناءً على العناوين المختارة
  List<String> getSelectedRoutes() {
    return inspectionTypes
        .where((type) => selectedTypes.contains(type['title']))
        .map((type) => type['route'] as String)
        .toList();
  }
  String getInspectionCategory() {
    return selectedTypes.isNotEmpty ? selectedTypes.join(', ') : 'لم يتم الاختيار';
  }


  /// بدء التنقل: استخراج المسارات المختارة، ثم ترتيبها عشوائيًا (يمكنك إزالة shuffle إذا أردت الترتيب حسب الاختيار)
  void startNavigation() {
    selectedRoutes = getSelectedRoutes();
    if (selectedRoutes.isEmpty) {
      Get.snackbar("تنبيه", "لم تقم بتحديد أي فحص");
      return;
    }
     // ترتيب عشوائي
    _currentPageIndex = 0;
    Get.toNamed(selectedRoutes[_currentPageIndex]);
    _currentPageIndex++;
  }

  /// الانتقال إلى الصفحة التالية من القائمة المختارة
  void navigateToNextSelectedPage() {
    // إذا لم تكن القائمة مهيأة، نستخرجها الآن
    if (selectedRoutes.isEmpty) {
      selectedRoutes = getSelectedRoutes();
    }
    if (_currentPageIndex < selectedRoutes.length) {
      Get.toNamed(selectedRoutes[_currentPageIndex]);
      _currentPageIndex++;
      print('Current index: $_currentPageIndex');
    } else {
      // عند انتهاء جميع الصفحات المختارة، ننتقل إلى صفحة التقرير النهائي
      Get.toNamed(Routes.REPORT_SUCCESS);
      _currentPageIndex = 0;
    }
  }

  /// إعادة تعيين التنقل إذا دعت الحاجة
  void resetNavigation() {
    _currentPageIndex = 0;
    selectedRoutes = [];
  }
}
