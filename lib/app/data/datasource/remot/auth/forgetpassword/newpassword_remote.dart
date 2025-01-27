import 'package:ersei/app/applinks.dart';
import 'package:ersei/app/core/class/crud.dart';
class NewPassword{
  Crud crud ;
  NewPassword(this.crud);


  postData(String password,)async{
    var response = await crud.postData(AppLink.verifySignCode, {


      'email':password,


    });
    return response.fold((l) => l, (r) => r);
  }
}