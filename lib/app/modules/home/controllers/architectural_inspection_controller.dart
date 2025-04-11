import 'dart:convert';
import 'dart:io';

import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;




abstract class ArchitecturalInspectionController extends GetxController {}

class ArchitecturalInspectionControllerImp extends ArchitecturalInspectionController {
  final ImagePicker picker = ImagePicker();
  // Map to store all inspection data (dropdowns, checkboxes, inputs, etc.)
  var inspectionData = RxMap<String, dynamic>();

  // Mapping for dropdown ratings: text to numeric value
  final Map<String, int> ratingMap = {
    'ممتاز': 100,
    'جيد': 75,
    'متوسط': 50,
    'سيء': 25,
  };

  // ------------------- Image Picking -------------------
  Future<void> pickImage(BuildContext context, String formKey, String imageKey) async {
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
        try {
          // استخراج الامتداد من الصورة الأصلية
          final extension = path.extension(pickedImage.path);

          // توليد اسم جديد للصورة باستخدام formKey و imageKey
          final fileName = '$formKey\_$imageKey$extension';

          // تحديد المسار لحفظ الصورة
          final appDir = await getApplicationDocumentsDirectory();
          final photosDir = Directory(path.join(appDir.path, 'photos'));
          if (!await photosDir.exists()) {
            await photosDir.create(recursive: true);
          }

          final savedImagePath = path.join(photosDir.path, fileName);
          final savedImage = await File(pickedImage.path).copy(savedImagePath);

          // تحويل الصورة إلى base64
          final imageBytes = await savedImage.readAsBytes();
          final base64Image = base64Encode(imageBytes);
          final base64WithHeader = "data:image/${extension.replaceFirst('.', '')};base64,$base64Image";

          // تخزين البيانات
          inspectionData['${formKey}_$imageKey'] = {
            "path": savedImage.path,
            "fileName": fileName,
            "extension": extension,
            "base64": base64WithHeader
          };

          print("✅ تم حفظ الصورة بنجاح باسم: $fileName");
        } catch (e) {
          print("❌ فشل حفظ الصورة: $e");
        }
      }
    }
  }

  // ------------------- Value Updating -------------------
  /// Update dropdowns and checkboxes.
  /// For dropdowns: store both the selected text (for display) and its numeric value (for calculation).
  /// For checkboxes: store the boolean value and 100 if true, 0 if false.
  void updateValue(String formKey, String key, dynamic value) {
    if (value is String && ratingMap.containsKey(value)) {
      // Store original text for the UI:
      inspectionData['${formKey}_$key'] = value;
      // Also store numeric value under a separate key:
      inspectionData['${formKey}_${key}_numeric'] = ratingMap[value]!;
    } else if (value is bool) {
      // Store the boolean value (if needed for UI logic)
      inspectionData['${formKey}_$key'] = value;
      // Also store numeric equivalent
      inspectionData['${formKey}_${key}_numeric'] = value ? 100 : 0;
    } else {
      // For other types (like raw input numbers), store directly.
      inspectionData['${formKey}_$key'] = value;
      if (value is int || value is double) {
        inspectionData['${formKey}_${key}_numeric'] = value;
      }
    }
  }

  // ------------------- Calculation Functions -------------------
  /// Computes the total by summing all numeric values stored in keys ending with '_numeric'.
  int computeTotal() {
    int total = 0;
    inspectionData.forEach((k, v) {
      if (k.endsWith('_numeric') && v is int) {
        total += v;
      }
    });
    return total;
  }

  /// Computes the average of all numeric values stored in keys ending with '_numeric'.
  double computeAverage() {
    int count = 0;
    int sum = 0;
    inspectionData.forEach((k, v) {
      if (k.endsWith('_numeric') && v is int) {
        count++;
        sum += v;
      }
    });
    return count > 0 ? sum / count : 0.0;
  }

  // ------------------- Form Submission -------------------
  void submitForm() {
    print("📌 البيانات المدخلة في الصفحة الحالية:");
    inspectionData.forEach((key, value) {
      print("$key: $value");
    });

    // تحويل `reportData` إلى `Map<String, dynamic>` بشكل صريح
    Map<String, dynamic> previousData =
        (Get.arguments?['reportData'] as Map?)?.cast<String, dynamic>() ?? {};

    // حساب الإجمالي والمتوسط
    int total = computeTotal();
    double average = computeAverage();
    print("✅ الإجمالي: $total");
    print("✅ المتوسط: $average");

    // دمج البيانات الحالية مع البيانات السابقة
    previousData.addAll(inspectionData);
    previousData['total'] = total;       // إضافة الإجمالي
    previousData['average'] = average;   // إضافة المتوسط

    // استرجاع قائمة الصفحات المتبقية وتحويلها إلى `List<String>`
    List<String> remainingPages =
        (Get.arguments?['remainingPages'] as List?)?.cast<String>() ?? [];

    // استرجاع نوع الفحص
    final String inspectionCategory = Get.arguments?['inspectionCategory'] ?? 'غير محدد';

    print("📌 البيانات المجمعة بعد التحديث:");
    previousData.forEach((key, value) {
      print("$key: $value");
    });

    // التحقق مما إذا كانت هناك صفحات متبقية للانتقال إليها
    if (remainingPages.isNotEmpty) {
      final String nextRoute = remainingPages.removeAt(0);
      print("🚀 الانتقال إلى الصفحة التالية: $nextRoute");
      Get.toNamed(nextRoute, arguments: {
        'reportData': previousData,
        'remainingPages': remainingPages,
        'inspectionCategory': inspectionCategory,
      });
    } else {
      print("✅ لا توجد صفحات متبقية، الانتقال إلى صفحة التقرير النهائي");
      Get.toNamed(Routes.REPORT_SUCCESS, arguments: {
        'reportData': previousData,
        'inspectionCategory': inspectionCategory,
      });
    }
  }
}
