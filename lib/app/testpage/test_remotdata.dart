import 'package:ersei/app/applinks.dart';
import 'package:ersei/app/core/class/crud.dart';

class TestData {

  late Crud curd ;

  TestData(this.curd);

  getData() async{
    var response =await curd.postData(AppLink.testView, {});
    return response.fold((l) => l, (r) => r);

  }

}