import 'package:get/get.dart';

class ArchitecturalInspectionController extends GetxController {
  // مطابقة المخطط مع المنفذ
  final selectedPlanImages = <String>[].obs;
  final planMatchingRate = ''.obs;

  // فحص المواد
  final selectedMaterials = <String>[].obs;
  final materialTypes = <String, String>{}.obs;
  final workQuality = <String, String>{}.obs;
  final crackStatus = <String, String>{}.obs;
  final selectedImages = <String, List<String>>{}.obs;

  void addPlanImage(String type, String imagePath) {
    if (type == 'مخطط') {
      selectedPlanImages.add(imagePath);
    }
  }

  void updatePlanMatchingRate(String rate) {
    planMatchingRate.value = rate;
  }

  void toggleMaterial(String material) {
    if (selectedMaterials.contains(material)) {
      selectedMaterials.remove(material);
    } else {
      selectedMaterials.add(material);
    }
  }

  void updateMaterialType(String material, String type) {
    materialTypes[material] = type;
  }

  void updateWorkQuality(String material, String quality) {
    workQuality[material] = quality;
  }

  void updateCrackStatus(String material, String status) {
    crackStatus[material] = status;
  }

  void addMaterialImage(String material, String imagePath) {
    if (!selectedImages.containsKey(material)) {
      selectedImages[material] = [];
    }
    selectedImages[material]!.add(imagePath);
  }
}
