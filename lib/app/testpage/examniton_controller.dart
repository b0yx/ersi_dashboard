import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';



class ExamnitonController extends GetxController {
  final ImagePicker picker = ImagePicker();

  /// خريطة لتخزين كافة البيانات (صور، اختيار منسدلة، مربعات اختيار، ...)
  var inspectionData = RxMap<String, dynamic>();

  /// دالة عامة لالتقاط صورة وتخزينها في [inspectionData] باستخدام المفتاح (key)
  Future<void> pickImage(BuildContext context, String key) async {
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
        inspectionData[key] = pickedImage.path;
      }
    }
  }

  /// دالة عامة لتحديث أي قيمة من الواجهة (سواء كانت اختيار منسدلة أو مربع اختيار)
  void updateValue(String key, dynamic value) {
    inspectionData[key] = value;
  }

  /// دالة لطباعة جميع البيانات المُجمعة
  void submitForm() {
    print("البيانات المدخلة في الفحص المعماري:");
    inspectionData.forEach((key, value) {
      print("$key: $value");
    });
  }
}
