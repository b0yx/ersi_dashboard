import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';


abstract class StructuralInspectionController extends GetxController {}

class StructuralInspectionControllerImp extends StructuralInspectionController {
  final ImagePicker picker = ImagePicker();

  // تخزين بيانات الفحص لجميع النماذج
  var inspectionData = RxMap<String, dynamic>();

  // خريطتان لتخزين متحكمات الإدخال والقيم التفاعلية للإخراج لكل نموذج
  Map<String, TextEditingController> hammerInputControllers = {};
  Map<String, RxString> hammerOutputRxMap = {};

  // تحويل التقييم من النص إلى قيمة رقمية
  final Map<String, int> ratingMap = {
    'ممتاز': 100,
    'جيد': 75,
    'متوسط': 50,
    'سيء': 25,
  };

  // جدول تحويل قراءة المطرقة إلى مقاومة الخرسانة (MPa)
  final Map<int, double> hammerConversion = {
    20: 9.9,
    21: 11.1,
    22: 12.4,
    23: 13.6,
    24: 14.9,
    25: 16.3,
    26: 17.7,
    27: 19.1,
    28: 20.6,
    29: 22.1,
    30: 23.6,
    31: 25.2,
    32: 26.9,
    33: 28.5,
    34: 30.1,
    35: 31.8,
    36: 33.6,
    37: 35.3,
    38: 37.0,
    39: 38.7,
    40: 40.5,
    41: 42.4,
    42: 44.1,
    43: 46.0,
    44: 47.9,
    45: 49.7,
    46: 51.6,
    47: 53.5,
    48: 55.4,
    49: 57.3,
    50: 59.3,
    51: 61.1,
    52: 63.1,
    53: 65.0,
    54: 67.0,
    55: 69.0,
  };

  // ------------------- التقاط الصور -------------------
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

  // ------------------- تحديث القيم -------------------
  /// تحديث قيم عناصر الإدخال (dropdowns، checkboxes) لنموذج محدد.
  void updateValue(String formKey, String key, dynamic value) {
    if (value is String && ratingMap.containsKey(value)) {
      inspectionData['${formKey}_$key'] = value;
      inspectionData['${formKey}_${key}_numeric'] = ratingMap[value]!;
    } else if (value is bool) {
      inspectionData['${formKey}_$key'] = value;
      inspectionData['${formKey}_${key}_numeric'] = value ? 100 : 0;
    } else {
      inspectionData['${formKey}_$key'] = value;
      if (value is int || value is double) {
        inspectionData['${formKey}_${key}_numeric'] = value;

      }
    }
  }

  /// تحديث قيمة حقل الإدخال الخاص بـ "قراءة المطرقة" لنموذج محدد.
  /// يتم دعم إدخال رقمين مفصولين بفاصلة أو فراغ، وفي كل جزء يتم تقييد الرقم بحيث لا يتجاوز خانتين وفي النطاق (20–55).
  void updateInputValue(String formKey, String key, String value) {
    if (key == "قراءة المطرقة") {
      // تأكد من وجود متغير Rx لهذا النموذج
      if (!hammerOutputRxMap.containsKey(formKey)) {
        hammerOutputRxMap[formKey] = ''.obs;
      }
      // تقسيم النص بناءً على الفواصل أو الفراغات
      List<String> parts = value.split(RegExp(r'[,\s]+')).where((s) => s.isNotEmpty).toList();
      if (parts.isEmpty) {
        inspectionData['${formKey}_قراءة المطرقة'] = null;
        hammerOutputRxMap[formKey]!.value = '';
      } else if (parts.length >= 2) {
        // حالة إدخال رقمين
        String part1 = parts[0].length > 2 ? parts[0].substring(0, 2) : parts[0];
        String part2 = parts[1].length > 2 ? parts[1].substring(0, 2) : parts[1];
        int reading1 = int.tryParse(part1) ?? 0;
        int reading2 = int.tryParse(part2) ?? 0;
        // تقييد القيم في النطاق (20–55)
        reading1 = reading1 < 20 ? 20 : reading1 > 55 ? 55 : reading1;
        reading2 = reading2 < 20 ? 20 : reading2 > 55 ? 55 : reading2;
        inspectionData['${formKey}_قراءة المطرقة_input1'] = reading1;
        inspectionData['${formKey}_قراءة المطرقة_input2'] = reading2;
        double concreteStrength1 = hammerConversion[reading1] ?? 0.0;
        double concreteStrength2 = hammerConversion[reading2] ?? 0.0;
        String output = '$concreteStrength1 , $concreteStrength2';
        inspectionData['${formKey}_مقاومة الخرسانة_output'] = output;
        hammerOutputRxMap[formKey]!.value = output;
      } else {
        // حالة إدخال رقم واحد
        String part = parts[0].length > 2 ? parts[0].substring(0, 2) : parts[0];
        int reading = int.tryParse(part) ?? 0;
        reading = reading < 20 ? 20 : reading > 55 ? 55 : reading;
        inspectionData['${formKey}_قراءة المطرقة'] = reading;
        double concreteStrength = hammerConversion[reading] ?? 0.0;
        inspectionData['${formKey}_مقاومة الخرسانة_output'] = concreteStrength;
        hammerOutputRxMap[formKey]!.value = concreteStrength.toString();
      }
      update();
    } else {
      // لباقي الحقول
      int numericValue = int.tryParse(value) ?? 1;
      inspectionData['${formKey}_$key'] = numericValue;
      update();
    }
  }

  /// استرجاع قيمة الإخراج لحقل معين لنموذج محدد
  String getOutputValue(String formKey, String key) {
    if (key == "مقاومة الخرسانة") {
      return hammerOutputRxMap[formKey]?.value ?? '';
    }
    return inspectionData['${formKey}_${key}_output']?.toString() ?? '';
  }

  // ------------------- دوال الحساب -------------------
  int computeTotal() {
    int total = 0;
    inspectionData.forEach((k, v) {
      if (k.endsWith('_numeric') && v is int) {
        total += v;
      }
    });
    return total;
  }

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

  // ------------------- إرسال النموذج -------------------
  void submitForm() {
    print("البيانات المدخلة:");
    inspectionData.forEach((key, value) {
      print("$key: $value");
    });
    int total = computeTotal();
    double average = computeAverage();
    print("الإجمالي: $total");
    print("المتوسط: $average");

    final Map<String, dynamic> args = Get.arguments ?? {};
    List<String> remainingPages = [];
    if (args.containsKey('remainingPages') && args['remainingPages'] != null) {
      remainingPages = List<String>.from(args['remainingPages']);
    }
    final String inspectionCategory = args['inspectionCategory'] ?? 'غير محدد';

    if (remainingPages.isNotEmpty && remainingPages.first.isNotEmpty) {
      final String nextRoute = remainingPages.removeAt(0);
      Get.toNamed(nextRoute, arguments: {
        'remainingPages': remainingPages,
        'inspectionCategory': inspectionCategory,
      });
    } else {
      Get.toNamed(Routes.REPORT_SUCCESS, arguments: {
        'inspectionCategory': inspectionCategory,
      });
    }
  }

  @override
  void onClose() {
    inspectionData.close();
    // تحرير جميع متحكمات الإدخال
    hammerInputControllers.forEach((key, controller) => controller.dispose());
    super.onClose();
  }
}
