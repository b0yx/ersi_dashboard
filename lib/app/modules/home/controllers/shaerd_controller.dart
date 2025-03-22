// shared_controller.dart
import 'package:get/get.dart';

class SharedController extends GetxController {
  /// خريطة تُخزن بيانات كل صفحة باستخدام مفتاح الصفحة
  RxMap<String, Map<String, dynamic>> pagesData = RxMap<String, Map<String, dynamic>>();

  /// دالة لتحديث بيانات صفحة معينة
  void updatePageData(String pageKey, String key, dynamic value) {
    if (pagesData[pageKey] == null) {
      pagesData[pageKey] = {};
    }
    pagesData[pageKey]![key] = value;
  }

  /// الحصول على البيانات المجمعة
  Map<String, Map<String, dynamic>> get finalData => pagesData;
}
