import 'package:ersei/app/core/class/handlingdataview.dart';
import 'package:ersei/app/core/class/statusrequest.dart';
import 'package:ersei/app/testpage/test_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TestController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestView'),
      ),
      body: GetBuilder<TestController>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return const HandlingDataView(
              statusRequest: StatusRequest.loading,
              widget: Center(child: CircularProgressIndicator()),
            );
          } else if (controller.data.isEmpty) {
            return const Center(child: Text('لا توجد بيانات لعرضها'));
          } else {
            return ListView.builder(
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${controller.data[index]}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}



//
// class TestView extends StatelessWidget {
//   const TestView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(TestController());
//     return Scaffold(
//       appBar: AppBar(title:const Text('TestView'),
//       ),
//       body: GetBuilder<TestController>(builder:(controller){
//         if(controller.statusRequest ==StatusRequest.loading){
//           return const HandlingDataView(statusRequest: StatusRequest.loading, widget: Card());
//         }else {
//           return ListView.builder(
//               itemCount: controller.data.length,
//               itemBuilder: (context ,index ){
//               return Text('${controller.data}');
//               },
//           );
//         }
//
//       },
//       ),
//
//
//     );
//   }
// }
