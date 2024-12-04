import 'package:get/get.dart';

class MechanicalInspectionController extends GetxController {
  final selectedPlumbing = false.obs;
  final selectedSewage = false.obs;
  final selectedElements = false.obs;
  final selectedRainwater = false.obs;
  
  // Material Quality
  final materialType = ''.obs;
  final materialQuality = ''.obs;
  
  // Tanks
  final surfaceTankType = 'بلاستيك'.obs;
  final surfaceTankCondition = 'جيد'.obs;
  final groundTankType = 'اسمنتي'.obs;
  final groundTankCondition = 'ممتاز'.obs;
}
