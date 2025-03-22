import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';


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
        inspectionData['${formKey}_$imageKey'] = pickedImage.path;
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
    // Before submission, ensure that input fields are updated.
    // For example, if you have TextEditingControllers in your view,
    // call updateInputValue() for each before submitForm().

    print("البيانات المدخلة:");
    inspectionData.forEach((key, value) {
      print("$key: $value");
    });

    int total = computeTotal();
    double average = computeAverage();
    print("الإجمالي: $total");
    print("المتوسط: $average");

    // Retrieve arguments from previous page (if any)
    final Map<String, dynamic> args = Get.arguments ?? {};
    List<String> remainingPages = [];
    if (args.containsKey('remainingPages') && args['remainingPages'] != null) {
      remainingPages = List<String>.from(args['remainingPages']);
    }
    final String inspectionCategory = args['inspectionCategory'] ?? 'غير محدد';

    // Navigate to the next page if available.
    if (remainingPages.isNotEmpty && remainingPages.first.isNotEmpty) {
      final String nextRoute = remainingPages.removeAt(0);
      Get.toNamed(nextRoute, arguments: {
        'remainingPages': remainingPages,
        'inspectionCategory': inspectionCategory,
      });
    } else {
      // Otherwise, go to the final report screen.
      Get.toNamed(Routes.REPORT_SUCCESS, arguments: {
        'inspectionCategory': inspectionCategory,
      });
    }
  }

  @override
  void onClose() {
    inspectionData.close();
    super.onClose();
  }
}
