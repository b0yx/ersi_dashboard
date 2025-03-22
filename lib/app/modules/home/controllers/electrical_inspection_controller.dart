

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

abstract class ElectricalInspectionController extends GetxController {

}

class ElectricalInspectionControllerImp extends ElectricalInspectionController {
  final ImagePicker picker = ImagePicker();

  // خريطة لتخزين البيانات لكل نموذج باستخدام مفاتيح مميزة
  var inspectionData = RxMap<String, dynamic>();

  Future<void> pickImage(BuildContext context, String formKey, String imageKey) async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(
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
        // يتم تخزين الصورة تحت مفتاح يتكون من مفتاح النموذج ومفتاح الصورة
        inspectionData['${formKey}_$imageKey'] = pickedImage.path;
      }
    }
  }

  void updateValue(String formKey, String key, dynamic value) {
    // تخزين القيمة باستخدام مفتاح يتكون من مفتاح النموذج والمفتاح الخاص بالعنصر
    inspectionData['${formKey}_$key'] = value;
  }

  void submitForm() {
    print("البيانات المدخلة:");
    inspectionData.forEach((key, value) {
      print("$key: $value");
    });
    final Map<String, dynamic> args = Get.arguments ?? {};
    List<String> remainingPages = args['remainingPages'] != null
        ? List<String>.from(args['remainingPages'])
        : [];
    final String inspectionCategory =
        args['inspectionCategory'] ?? "غير محدد";

    // التحقق من وجود صفحات متبقية للتنقل إليها
    if (remainingPages.isNotEmpty) {
      final String nextRoute = remainingPages.removeAt(0);
      print('الصفحة التالية');
      if (nextRoute.isEmpty) {
        // في حالة عدم توفر مسار صالح، الانتقال إلى صفحة التقرير النهائي
        print('المسار غير صالح ');
        Get.toNamed(Routes.REPORT_SUCCESS, arguments: {
          "inspectionCategory": inspectionCategory,
        });
      } else {
        // الانتقال إلى الصفحة التالية مع تمرير القائمة المحدثة
        Get.toNamed(nextRoute, arguments: {
          "remainingPages": remainingPages,
          "inspectionCategory": inspectionCategory,
        });
      }
    } else {
      // إذا لم يتبقَ صفحات، الانتقال إلى صفحة التقرير النهائي
      print('لا يوجد صفحات ');
      Get.toNamed(Routes.REPORT_SUCCESS, arguments: {
        "inspectionCategory": inspectionCategory,
      });
    }
  }

// class ArchitecturalInspectionControllerImp extends ArchitecturalInspectionController {
//   final ImagePicker picker = ImagePicker();
//
//   var firstImage = Rx<XFile?>(null);
//   var secondImage = Rx<XFile?>(null);
//   var inspectionData = RxMap<String, dynamic>();
//   var checkboxDataTiles = RxMap<String, dynamic>();
//
//   Future<void> _pickImage(BuildContext context, Function(XFile) onImagePicked) async {
//     final ImageSource? source = await showDialog<ImageSource>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("اختر مصدر الصورة"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, ImageSource.camera),
//             child: const Text("الكاميرا"),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, ImageSource.gallery),
//             child: const Text("المعرض"),
//           ),
//         ],
//       ),
//     );
//
//     if (source != null) {
//       final pickedImage = await picker.pickImage(source: source);
//       if (pickedImage != null) {
//         onImagePicked(pickedImage);
//       }
//     }
//   }
//
//   Future<void> pickFirstImage(BuildContext context) async {
//     await _pickImage(context, (pickedImage) {
//       firstImage.value = pickedImage;
//       inspectionData['firstImage'] = pickedImage.path;
//     });
//   }
//
//   Future<void> pickSecondImage(BuildContext context) async {
//     await _pickImage(context, (pickedImage) {
//       secondImage.value = pickedImage;
//       inspectionData['secondImage'] = pickedImage.path;
//     });
//   }
//
//   ////////////////////////بلاط الارضية ////////////////////////
//   var selectedTileType = InspectionState.tileType.obs;
//   var selectedTileState = InspectionState.tileCondition.obs;
//   void updateDropdown(String key, dynamic value) {
//     inspectionData[key] = value; // تخزين القيمة في الـ Map
//     if (key == InspectionState.tileType) {
//       selectedTileType.value = value; // تحديث المتغير RxString
//       // تحديث المتغير RxString
//     }else if(key == InspectionState.tileCondition) {
//       selectedTileState.value = value;
//     }
//   }
//   void updateCheckbox(String key, bool value) {
//     inspectionData[key] = value;
//   }
//
//   ////////////////////////////////////////////////////////////
//
//
//   //////////////////بلاط الجدران
//   var selectedTileTileWallType = InspectionState.tileType.obs;
//   var selectedTileTileWallCondition = InspectionState.tileCondition.obs;
//   void updateDropdownTileWall(String key, dynamic value) {
//     inspectionData[key] = value; // تخزين القيمة في الـ Map
//     if (key == InspectionState.tileType) {
//       selectedTileTileWallType.value = value; // تحديث المتغير RxString
//       // تحديث المتغير RxString
//     }else if(key == InspectionState.tileCondition) {
//       selectedTileTileWallCondition.value = value;
//     }
//   }
//   void updateCheckboxTileWall(String key, bool value2) {
//     checkboxDataTiles[key] = value2;
//   }
//
//   void updateDropdownAll(String key, dynamic value) {
//     inspectionData[key] = value;
//   }
//
//
//
//   void submitForm() {
//     print(" البيانات المدخلة في الفحص المعماري:");
//     inspectionData.forEach((key, value) {
//       print("$key: $value");
//     });
//     checkboxDataTiles.forEach((key, value) {
//       print("$key: $value");
//     });
//   }
//
//
// }

}