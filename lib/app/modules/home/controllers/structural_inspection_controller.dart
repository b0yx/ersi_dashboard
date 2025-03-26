import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

abstract class StructuralInspectionController extends GetxController {}

class StructuralInspectionControllerImp extends StructuralInspectionController {
  final ImagePicker picker = ImagePicker();

  // تخزين بيانات النماذج الثابتة
  var inspectionData = RxMap<String, dynamic>();

  // متحكمات الإدخال والقيم التفاعلية للنماذج الثابتة
  Map<String, TextEditingController> hammerInputControllers = {};
  Map<String, RxString> hammerOutputRxMap = {};

  // ------------------- المتغيرات الخاصة بالنماذج المتكررة -------------------
  // خريطة تخزن بيانات النماذج المتكررة لكل قسم
  Map<String, RxList<Map<String, dynamic>>> repeatedInspectionData = {};
  // تخزين متحكمات الإدخال لكل نموذج متكرر، مفهرسة حسب اسم القسم
  Map<String, List<TextEditingController>> repeatedInputControllers = {};
  // تخزين المتغيرات التفاعلية للإخراج لكل نموذج متكرر
  Map<String, List<RxString>> repeatedOutputRx = {};

  // تحويل التقييم من النص إلى قيمة رقمية
  final Map<String, int> ratingMap = {
    'مطابق': 100,
    'غير مطابق': 25,
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

  // ------------------- دوال النماذج الثابتة -------------------
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

  void updateInputValue(String formKey, String key, String value) {
    if (key == "قراءة المطرقة") {
      if (!hammerOutputRxMap.containsKey(formKey)) {
        hammerOutputRxMap[formKey] = ''.obs;
      }
      List<String> parts = value.split(RegExp(r'[,\s]+')).where((s) => s.isNotEmpty).toList();
      if (parts.isEmpty) {
        inspectionData['${formKey}_قراءة المطرقة'] = null;
        hammerOutputRxMap[formKey]!.value = '';
      } else if (parts.length >= 2) {
        String part1 = parts[0].length > 2 ? parts[0].substring(0, 2) : parts[0];
        String part2 = parts[1].length > 2 ? parts[1].substring(0, 2) : parts[1];
        int reading1 = int.tryParse(part1) ?? 0;
        int reading2 = int.tryParse(part2) ?? 0;
        reading1 = reading1 < 20 ? 20 : reading1 > 55 ? 55 : reading1;
        reading2 = reading2 < 20 ? 20 : reading2 > 55 ? 55 : reading2;
        inspectionData['${formKey}_قراءة المطرقة_input1'] = reading1;
        inspectionData['${formKey}_قراءة المطرقة_input2'] = reading2;
        double concreteStrength1 = hammerConversion[reading1] ?? 0.0;
        double concreteStrength2 = hammerConversion[reading2] ?? 0.0;
        String output = '$concreteStrength1 , $concreteStrength2';
        inspectionData['${formKey}_مقاومة الخرسانة_output'] = output;
        // تخزين القيمة الرقمية (مثلاً من القراءة الأولى)
        inspectionData['${formKey}_مقاومة الخرسانة_numeric'] = concreteStrength1.toInt();
        hammerOutputRxMap[formKey]!.value = output;
      } else {
        String part = parts[0].length > 2 ? parts[0].substring(0, 2) : parts[0];
        int reading = int.tryParse(part) ?? 0;
        reading = reading < 20 ? 20 : reading > 55 ? 55 : reading;
        inspectionData['${formKey}_قراءة المطرقة'] = reading;
        double concreteStrength = hammerConversion[reading] ?? 0.0;
        inspectionData['${formKey}_مقاومة الخرسانة_output'] = concreteStrength;
        // تخزين القيمة الرقمية
        inspectionData['${formKey}_مقاومة الخرسانة_numeric'] = concreteStrength.toInt();
        hammerOutputRxMap[formKey]!.value = concreteStrength.toString();
      }
      update();
    } else {
      int numericValue = int.tryParse(value) ?? 1;
      inspectionData['${formKey}_$key'] = numericValue;
      update();
    }
  }

  String getOutputValue(String formKey, String key) {
    if (key == "مقاومة الخرسانة") {
      return hammerOutputRxMap[formKey]?.value ?? '';
    }
    return inspectionData['${formKey}_${key}_output']?.toString() ?? '';
  }

  // ------------------- دوال النماذج المتكررة -------------------
  // إضافة نموذج متكرر لقسم معين (مثال: "فحص القواعد")
  void addRepeatedForm(String section) {
    if (!repeatedInspectionData.containsKey(section)) {
      repeatedInspectionData[section] = <Map<String, dynamic>>[].obs;
      repeatedInputControllers[section] = [];
      repeatedOutputRx[section] = [];
    }
    // عند الإضافة، نستخدم القيمة الافتراضية 'مطابق' مع تخزين القيمة الرقمية
    repeatedInspectionData[section]!.add({
      'image1': null,
      'image2': null,
      'hammerReading': '',
      'reinforcement': 'المطابقة',
      'reinforcement_numeric': ratingMap[''],
      'concreteStrength': '',
      'concreteStrength_numeric': 0,
    });
    repeatedInputControllers[section]!.add(TextEditingController());
    repeatedOutputRx[section]!.add(''.obs);
    update();
  }

  // استرجاع متحكم الإدخال لنموذج متكرر في قسم محدد
  TextEditingController getInputController(String section, int index) {
    if (repeatedInputControllers.containsKey(section)) {
      return repeatedInputControllers[section]![index];
    }
    repeatedInputControllers[section] = [];
    repeatedInputControllers[section]!.add(TextEditingController());
    return repeatedInputControllers[section]![index];
  }

  // استرجاع Rx الخاص بالإخراج لنموذج متكرر في قسم محدد
  RxString getOutputRx(String section, int index) {
    if (repeatedOutputRx.containsKey(section)) {
      return repeatedOutputRx[section]![index];
    }
    repeatedOutputRx[section] = [];
    repeatedOutputRx[section]!.add(''.obs);
    return repeatedOutputRx[section]![index];
  }

  // تحديث قيمة قراءة المطرقة والإخراج لنموذج متكرر
  void updateRepeatedInputValue(String section, int index, String value) {
    List<String> parts = value.split(RegExp(r'[,\s]+')).where((s) => s.isNotEmpty).toList();
    if (parts.isEmpty) {
      repeatedInspectionData[section]![index]['hammerReading'] = null;
      repeatedOutputRx[section]![index].value = '';
      repeatedInspectionData[section]![index]['concreteStrength_numeric'] = 0;
    } else if (parts.length >= 2) {
      String part1 = parts[0].length > 2 ? parts[0].substring(0, 2) : parts[0];
      String part2 = parts[1].length > 2 ? parts[1].substring(0, 2) : parts[1];
      int reading1 = int.tryParse(part1) ?? 0;
      int reading2 = int.tryParse(part2) ?? 0;
      reading1 = reading1 < 20 ? 20 : reading1 > 55 ? 55 : reading1;
      reading2 = reading2 < 20 ? 20 : reading2 > 55 ? 55 : reading2;
      repeatedInspectionData[section]![index]['hammerReading'] = '$reading1 , $reading2';
      double concreteStrength1 = hammerConversion[reading1] ?? 0.0;
      double concreteStrength2 = hammerConversion[reading2] ?? 0.0;
      String output = '$concreteStrength1 , $concreteStrength2';
      repeatedInspectionData[section]![index]['concreteStrength'] = output;
      // تخزين القيمة الرقمية بناءً على أول قراءة
      repeatedInspectionData[section]![index]['concreteStrength_numeric'] = concreteStrength1.toInt();
      repeatedOutputRx[section]![index].value = output;
    } else {
      String part = parts[0].length > 2 ? parts[0].substring(0, 2) : parts[0];
      int reading = int.tryParse(part) ?? 0;
      reading = reading < 20 ? 20 : reading > 55 ? 55 : reading;
      repeatedInspectionData[section]![index]['hammerReading'] = reading;
      double concreteStrength = hammerConversion[reading] ?? 0.0;
      repeatedInspectionData[section]![index]['concreteStrength'] = concreteStrength;
      // تخزين القيمة الرقمية
      repeatedInspectionData[section]![index]['concreteStrength_numeric'] = concreteStrength.toInt();
      repeatedOutputRx[section]![index].value = concreteStrength.toString();
    }
    update();
  }

  // تحديث قيمة dropdown للنموذج المتكرر
  void updateRepeatedDropdownValue(String section, int index, String key, dynamic value) {
    if (value is String && ratingMap.containsKey(value)) {
      repeatedInspectionData[section]![index][key] = value;
      repeatedInspectionData[section]![index]['${key}_numeric'] = ratingMap[value]!;
    } else {
      repeatedInspectionData[section]![index][key] = value;
    }
    update();
  }

  // التقاط صورة لنموذج متكرر في قسم معين باستخدام Get.dialog وضمان تحديث العنصر فوراً
  Future<void> pickImageForRepeated(String section, int index, String imageKey) async {
    final ImageSource? source = await Get.dialog<ImageSource>(
      AlertDialog(
        title: const Text("اختر مصدر الصورة"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: ImageSource.camera),
            child: const Text("الكاميرا"),
          ),
          TextButton(
            onPressed: () => Get.back(result: ImageSource.gallery),
            child: const Text("المعرض"),
          ),
        ],
      ),
    );
    if (source != null) {
      final pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        // تحديث الصورة في العنصر وإجبار RxList على التعرف على التغيير
        repeatedInspectionData[section]![index][imageKey] = pickedImage.path;
        repeatedInspectionData[section]![index] = Map<String, dynamic>.from(repeatedInspectionData[section]![index]);
        update();
      }
    }
  }

  // ------------------- دوال الحساب -------------------
  int computeTotal() {
    int total = 0;
    // من النماذج الثابتة
    inspectionData.forEach((k, v) {
      if (k.endsWith('_numeric') && v is int && !k.contains('concreteStrength_numeric')) {
        total += v;
      }
    });
    // من النماذج المتكررة
    repeatedInspectionData.forEach((section, forms) {
      for (var formData in forms) {
        formData.forEach((k, v) {
          if (k.endsWith('_numeric') && v is int && !k.contains('concreteStrength_numeric')) {
            total += v;
          }
        });
      }
    });
    return total;
  }

  double computeAverage() {
    int count = 0;
    int sum = 0;
    // من النماذج الثابتة
    inspectionData.forEach((k, v) {
      if (k.endsWith('_numeric') && v is int && !k.contains('concreteStrength_numeric')) {
        sum += v;
        count++;
      }
    });
    // من النماذج المتكررة
    repeatedInspectionData.forEach((section, forms) {
      for (var formData in forms) {
        formData.forEach((k, v) {
          if (k.endsWith('_numeric') && v is int && !k.contains('concreteStrength_numeric')) {
            sum += v;
            count++;
          }
        });
      }
    });
    return count > 0 ? sum / count : 0.0;
  }


  // ------------------- إرسال النموذج -------------------
  void submitForm() {
    // طباعة البيانات الحالية للصفحة (لأغراض التتبع)
    print("البيانات المدخلة للنماذج الثابتة:");
    inspectionData.forEach((key, value) {
      print("$key: $value");
    });

    print("البيانات المدخلة للنماذج المتكررة:");
    repeatedInspectionData.forEach((section, forms) {
      for (var formData in forms) {
        formData['section'] = section;
        print(formData);
      }
    });

    int total = computeTotal();
    double average = computeAverage();
    print("الإجمالي: $total");
    print("المتوسط: $average");

    // استلام البيانات السابقة (إن وجدت) من الصفحات السابقة
    Map<String, dynamic> previousData = {};
    if (Get.arguments != null && Get.arguments['reportData'] != null) {
      previousData = Map<String, dynamic>.from(Get.arguments['reportData']);
    }

    // دمج البيانات الثابتة للصفحة الحالية مع البيانات السابقة
    previousData.addAll(inspectionData);

    // دمج بيانات النماذج المتكررة
    Map<String, dynamic> mergedRepeatedData = {};
    repeatedInspectionData.forEach((section, forms) {
      mergedRepeatedData[section] = forms.toList();
    });
    previousData['repeatedData'] = mergedRepeatedData;

    // استرجاع معطيات أخرى مثل فئة الفحص
    final String inspectionCategory = Get.arguments?['inspectionCategory'] ?? 'غير محدد';

    // استلام قائمة الصفحات المتبقية إن وُجدت
    List<String> remainingPages = [];
    if (Get.arguments != null && Get.arguments['remainingPages'] != null) {
      remainingPages = List<String>.from(Get.arguments['remainingPages']);
    }

    // إذا كانت هناك صفحات متبقية، يتم تمرير البيانات إليها
    if (remainingPages.isNotEmpty && remainingPages.first.isNotEmpty) {
      final String nextRoute = remainingPages.removeAt(0);
      Get.toNamed(nextRoute, arguments: {
        'reportData': previousData,
        'remainingPages': remainingPages,
        'inspectionCategory': inspectionCategory,
      });
    } else {
      // إذا لم يتبق صفحات، الانتقال إلى صفحة ReportSuccess مع تمرير البيانات المجمعة
      Get.toNamed(Routes.REPORT_SUCCESS, arguments: {
        'reportData': previousData,
        'inspectionCategory': inspectionCategory,
      });
    }
  }

}
