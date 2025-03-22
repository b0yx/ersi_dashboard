// import 'dart:io';
// import 'package:ersei/app/modules/home/views/widget/custom_image_with_muldropdownlist.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'examniton_controller.dart'; // تأكد من مسار الاستيراد الصحيح
//
// class Examview extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // تسجيل الكنترولر باستخدام Get.put حتى يكون متاحاً في الواجهة
//     final controller = Get.put(ExamnitonController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("الفحص المعماري"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//
//               CustomImageMulForm(
//                   firstImage: Text("اختر صورة المخطط"),
//                   secondImage: secondImage,
//                   onPickFirstImage: () => controller.pickImage(context, 'مخطط'),
//                   onPickSecondImage: () => controller.pickImage(context, 'منفذ'),
//                   formName: 'formName'
//               ),
//
//               /// اختيار صورة المخطط (مثال على استخدام pickImage)
//               ElevatedButton(
//                 onPressed: () => controller.pickImage(context, 'مخطط'),
//                 child: Text("اختر صورة المخطط"),
//               ),
//               Obx(() => controller.inspectionData['مخطط'] != null
//                   ? Image.file(
//                 File(controller.inspectionData['مخطط']),
//                 height: 100,
//               )
//                   : Container()),
//               SizedBox(height: 20),
//
//               /// اختيار صورة المنفذ (مثال آخر)
//               ElevatedButton(
//                 onPressed: () => controller.pickImage(context, 'منفذ'),
//                 child: Text("اختر صورة المنفذ"),
//               ),
//               Obx(() => controller.inspectionData['منفذ'] != null
//                   ? Image.file(
//                 File(controller.inspectionData['منفذ']),
//                 height: 100,
//               )
//                   : Container()),
//               SizedBox(height: 20),
//
//               /// قائمة منسدلة لتحديد "نوع البلاط"
//               Obx(() => DropdownButton<String>(
//                 value: controller.inspectionData['نوع البلاط'] ?? 'جيد',
//                 onChanged: (value) {
//                   if (value != null) {
//                     controller.updateValue('نوع البلاط', value);
//                   }
//                 },
//                 items: ['ممتاز', 'جيد', 'متوسط', 'سيء']
//                     .map((val) => DropdownMenuItem<String>(
//                   value: val,
//                   child: Text(val),
//                 ))
//                     .toList(),
//               )),
//               SizedBox(height: 20),
//
//               /// مربع اختيار (Checkbox) لتحديد قيمة معينة (مثلاً "ميول")
//               Obx(() => CheckboxListTile(
//                 title: Text("ميول"),
//                 value: controller.inspectionData['ميول'] ?? false,
//                 onChanged: (value) {
//                   if (value != null) {
//                     controller.updateValue('ميول', value);
//                   }
//                 },
//               )),
//               SizedBox(height: 20),
//
//               ElevatedButton(
//                 onPressed: () => controller.pickImage(context, 'عادي 2'),
//                 child: Text("اختر صورة المخطط"),
//               ),
//               Obx(() => controller.inspectionData['عادي 2'] != null
//                   ? Image.file(
//                 File(controller.inspectionData['عادي 2']),
//                 height: 100,
//               )
//                   : Container()),
//               SizedBox(height: 20),
//
//               /// اختيار صورة المنفذ (مثال آخر)
//               ElevatedButton(
//                 onPressed: () => controller.pickImage(context, 'عادي'),
//                 child: Text("اختر صورة المنفذ"),
//               ),
//               Obx(() => controller.inspectionData['عادي'] != null
//                   ? Image.file(
//                 File(controller.inspectionData['عادي']),
//                 height: 100,
//               )
//                   : Container()),
//               SizedBox(height: 20),
//
//               /// قائمة منسدلة لتحديد "نوع البلاط"
//               Obx(() => DropdownButton<String>(
//                 value: controller.inspectionData['حالة البلاط'] ?? 'جيد',
//                 onChanged: (value) {
//                   if (value != null) {
//                     controller.updateValue('حالة البلاط', value);
//                   }
//                 },
//                 items: ['ممتاز', 'جيد', 'متوسط', 'سيء']
//                     .map((val) => DropdownMenuItem<String>(
//                   value: val,
//                   child: Text(val),
//                 ))
//                     .toList(),
//               )),
//               SizedBox(height: 20),
//
//               /// مربع اختيار (Checkbox) لتحديد قيمة معينة (مثلاً "ميول")
//               Obx(() => CheckboxListTile(
//                 title: Text("خواء"),
//                 value: controller.inspectionData['خواء'] ?? false,
//                 onChanged: (value) {
//                   if (value != null) {
//                     controller.updateValue('خواء', value);
//                   }
//                 },
//               )),
//               SizedBox(height: 20),
//
//               /// زر إرسال لطباعة جميع البيانات المُجمعة
//               ElevatedButton(
//                 onPressed: () => controller.submitForm(),
//                 child: Text("إرسال البيانات"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
