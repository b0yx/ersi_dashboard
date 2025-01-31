import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class ArchitecturalInspectionController extends GetxController {
  Future<void> pickFirstImage(BuildContext context);
  Future<void> pickSecondImage(BuildContext context);
}

class ArchitecturalInspectionControllerImp extends ArchitecturalInspectionController {
  final ImagePicker picker = ImagePicker();

  // الصور المختارة
  var firstImage = Rx<XFile?>(null); // الصورة الأولى
  var secondImage = Rx<XFile?>(null); // الصورة الثانية

  // اختيار مصدر الصورة
  Future<void> _pickImage(BuildContext context, Function(XFile) onImagePicked) async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("اختر مصدر الصورة"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: const Text("الكاميرا"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: const Text("المعرض"),
          ),
        ],
      ),
    );

    if (source != null) {
      final pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        onImagePicked(pickedImage);
      }
    }
  }

  // اختيار الصورة الأولى
  Future<void> pickFirstImage(BuildContext context) async {
    await _pickImage(context, (pickedImage) {
      firstImage.value = pickedImage;
    });
  }

  // اختيار الصورة الثانية
  Future<void> pickSecondImage(BuildContext context) async {
    await _pickImage(context, (pickedImage) {
      secondImage.value = pickedImage;
    });
  }
}
