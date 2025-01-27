import 'package:ersei/app/applinks.dart';
import 'package:ersei/app/core/class/crud.dart';
class CheckEmail{
  Crud crud ;
  CheckEmail(this.crud);


  postData(String phone)async{
    var response = await crud.postData(AppLink.forgetPassword, {
      'phone':phone,
    });
    return response.fold((l) => l, (r) => r);
  }
}