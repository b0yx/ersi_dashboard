import 'package:get/get.dart';

bool isArabicOnly(String input) {
  final arabicRegex = RegExp(r'^[\u0600-\u06FF\s]+$');
  return arabicRegex.hasMatch(input);
}

String? validInput(String val, int min, int max, String type) {
  // التحقق من نوع الحقل
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return 'اسم المستخدم غير صالح';
    }
  }

  if (type == "samplename") {
    if (!GetUtils.isAlphabetOnly(val) && !isArabicOnly(val)) {
      return 'يرجى إدخال حروف فقط';
    }
  }


  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return 'هذا البريد الإلكتروني غير صالح';
    }
  }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return 'رقم الهاتف غير صالح';
    }
  }

  if (type == "password") {
    if (!GetUtils.isUsername(val)) {
      return 'كلمة المرور غير صالحة';
    }
  }

  // التحقق من أن الحقل غير فارغ
  if (val.isEmpty) {
    return 'لا يجب أن يكون الحقل فارغًا';
  }

  // التحقق من الحد الأدنى للطول
  if (val.length < min) {
    return 'يجب ألا يقل عدد الأحرف عن $min';
  }

  // التحقق من الحد الأقصى للطول
  if (val.length > max) {
    return 'يجب ألا يزيد عدد الأحرف عن $max';
  }

  // إذا لم يكن هناك أخطاء
  return null;
}


//

// import 'package:get/get.dart';
//
// validInput(String val , int min ,int max ,String type){
//
//   if(type =="username"){
//     if(!GetUtils.isUsername(type)){
//       return 'اسم المستخدم غير صالح';
//     }
//   }
//
//   if(type =="email"){
//     if(!GetUtils.isEmail(type)){
//       return 'هذا البريد غير صالح';
//     }
//   }
//
//
//
//   if(type =="phone"){
//     if(!GetUtils.isPhoneNumber(type)){
//       return 'رقم الهاتف هذا غير صالح';
//     }
//   }
//
//   if(val.isEmpty){
//     return 'لايحب ان يكون الحقل فارغا' ;
//   }
//
//   if(val.length<min){
//     return 'لقد تحاوزت الحد الادني من $min';
//   }
//
//   if(val.length>max){
//     return 'لقد تحاوزت الحد الأعلى من $max';
//   }
//
//
//
//
// }