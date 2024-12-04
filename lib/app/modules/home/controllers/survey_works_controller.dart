import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SurveyWorksController extends GetxController {
  // مساحة الأرض
  final landArea = 'مطابق'.obs;
  
  // مساحة المبنى
  final buildingArea = 'غير مطابق'.obs;

  // قائمة الصور
  final landImages = <String>[].obs;
  final buildingImages = <String>[].obs;

  // إضافة صورة لمساحة الأرض
  Future<void> addLandImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      landImages.add(image.path);
    }
  }

  // إضافة صورة لمساحة المبنى
  Future<void> addBuildingImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      buildingImages.add(image.path);
    }
  }

  // حفظ كمسودة
  void saveAsDraft() {
    // TODO: Implement save as draft functionality
  }

  // الانتقال إلى الصفحة التالية
  void goToNext() {
    // TODO: Implement navigation to next page
  }
}