import 'package:get/get.dart';

class ReportSuccessController extends GetxController {
  // تخزين البيانات المجمعة المُرسلة من الصفحات السابقة
  final RxMap<String, dynamic> reportData = RxMap<String, dynamic>();

  // يمكنك إضافة متغيرات أخرى مثل فئة الفحص إن رغبت
  final RxString inspectionCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // التحقق من وجود البيانات في Get.arguments
    if (Get.arguments != null) {
      if (Get.arguments['reportData'] != null) {
        // استلام البيانات المجمعة وتعيينها
        reportData.assignAll(Get.arguments['reportData']);
        // طباعة البيانات في الكونسول للتأكد
        print("البيانات المجمعة للتقرير:");
        reportData.forEach((key, value) {
          print("$key: $value");
        });
      }
      // استلام فئة الفحص إن وُجدت
      if (Get.arguments['inspectionCategory'] != null) {
        inspectionCategory.value = Get.arguments['inspectionCategory'];
        print("فئة الفحص: ${inspectionCategory.value}");
      }
    }
  }
}
