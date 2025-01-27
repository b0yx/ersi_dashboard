
import 'package:ersei/app/applinks.dart';
import 'package:ersei/app/core/class/crud.dart';
class LoginData{
  Crud crud ;
  LoginData(this.crud);


  postData(phone , String password)async{
    var response = await crud.postData(AppLink.login, {
      'phone':phone,

      'password':password,

    });
    return response.fold((l) => l, (r) => r);
  }
}


//
// class SignupData{
//   Crud crud ;
//   SignupData(this.crud);
//   postData(String name ,String email,String phone,String password)async{
//     var response = await crud.postData(AppLink.signUp, {
//
//       'name':name,
//       'email':email,
//       'phone':phone,
//       'password':password,
//
//     });
//     return response.fold((l) => l, (r) => r);
//
//   }
//
// }