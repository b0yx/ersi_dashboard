import 'package:get/get.dart';

class ElectricalInspectionController extends GetxController {
  // النظام المستخدم
  final systemType = 'كهربائي'.obs;

  // الإضاءة
  final lightingType = 'مطابق'.obs;
  final lightingCondition = 'غير مطابق'.obs;
  final lightingDistribution = 'مطابق'.obs;

  // نظام المسارات
  final pathwayType = 'كهربائي'.obs;

  // المنافذ
  final outletsType = 'مطابق'.obs;
  final outletsCondition = 'غير مطابق'.obs;
  final outletsDistribution = 'مطابق'.obs;

  // المفاتيح
  final switchesType = 'مطابق'.obs;
  final switchesCondition = 'غير مطابق'.obs;
  final switchesDistribution = 'مطابق'.obs;

  // اللوحات الفرعية
  final subPanelsType = 'مطابق'.obs;
  final subPanelsCondition = 'غير مطابق'.obs;
  final subPanelsDistribution = 'مطابق'.obs;

  // القواطع
  final breakersType = 'مطابق'.obs;
  final breakersCondition = 'غير مطابق'.obs;
  final breakersDistribution = 'مطابق'.obs;

  // اللوحات الرئيسية
  final mainPanelsType = 'مطابق'.obs;
  final mainPanelsCondition = 'غير مطابق'.obs;
  final mainPanelsDistribution = 'مطابق'.obs;

  // الأسلاك
  final wiringType = 'بوري'.obs;
  final wiringSize = 'على قوة'.obs;
  final wiringConnection = 'مطابق'.obs;

  // الكيبلات الرئيسية
  final mainCablesType = 'بوري'.obs;
  final mainCablesSize = 'القوة 2'.obs;
  final mainCablesConnection = 'مطابق'.obs;

  // نظام التأريض
  final groundingSystem = 'كافي'.obs;
}
