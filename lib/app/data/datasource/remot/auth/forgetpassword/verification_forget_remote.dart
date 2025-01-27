import 'package:ersei/app/applinks.dart';
import 'package:ersei/app/core/class/crud.dart';
class VerificationPassword{
  Crud crud ;
  VerificationPassword(this.crud);


  postData(String email,String verificationCode)async{
    var response = await crud.postData(AppLink.verifyPassword, {


      'email':email,
      'verifycode':verificationCode,

    });
    return response.fold((l) => l, (r) => r);
  }
}