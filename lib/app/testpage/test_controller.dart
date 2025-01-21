import 'package:ersei/app/core/class/statusrequest.dart';
import 'package:ersei/app/core/functions/handlingdatacontroller.dart';
import 'package:ersei/app/testpage/test_remotdata.dart';
import 'package:get/get.dart';

class TestController extends GetxController{

  TestData testData = TestData(Get.find());

  List data =[];

   StatusRequest statusRequest = StatusRequest.none;

  getData() async{

    statusRequest =StatusRequest.loading;
    var response =await testData.getData();
    print('this is response for test controller $response');
    statusRequest = handlingData(response);
    if(StatusRequest.success == statusRequest)
      {
        data.addAll(response['data']);
        print('this is response from success controller $response');

      }
      update();

  }

@override
  void onInit() {
    getData();
    super.onInit();
  }
}


