import 'package:ersei/app/applinks.dart';
import 'package:ersei/app/core/class/crud.dart';
class VerificationSignupData{
  Crud crud ;
  VerificationSignupData(this.crud);


  postData(String email,String verificationCode)async{
    var response = await crud.postData(AppLink.verifySignCode, {


      'email':email,
      'users_verfiycode':verificationCode,

    });
    return response.fold((l) => l, (r) => r);
  }
}