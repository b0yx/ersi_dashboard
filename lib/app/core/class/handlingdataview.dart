import 'package:ersei/app/core/class/statusrequest.dart';
import 'package:ersei/app/core/constant/imagesassets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HandlingDataView extends StatelessWidget {
  const HandlingDataView({
    super.key,
    required this.statusRequest,
    required this.widget,
  });

  final StatusRequest statusRequest;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (statusRequest) {
      case StatusRequest.loading:
        content = Center(
          child: Lottie.asset(
            ImageAssets.loading,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        );
        break;
      case StatusRequest.success:
        content = Center(
          child: Lottie.asset(
            ImageAssets.success,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        );
        break;
      case StatusRequest.serverfailure:
        content = Center(
          child: Lottie.asset(
            ImageAssets.failure,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        );
        break;
      case StatusRequest.offlinefailure:
        content = Center(
          child: Lottie.asset(
            ImageAssets.noInternet,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        );
        break;
      case StatusRequest.failure:
        content = Center(
          child: Lottie.asset(
            ImageAssets.noData,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        );

        break;
      case StatusRequest.erorr:
        content = Center(
          child: Lottie.asset(
            ImageAssets.error,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        );
        break;
      case StatusRequest.invalidVerificationCode:
        content = Center(
          child: Lottie.asset(
            ImageAssets.invalidVerification,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        );

        break;
      default:
        content = widget;
    }

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: content,
      ),
    );
  }
}

// import 'package:ersei/app/core/class/statusrequest.dart';
// import 'package:ersei/app/core/constant/imagesassets.dart';
// import 'package:ersei/app/modules/home/views/widget/custometext.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:lottie/lottie.dart';
//
// class HabdlingDataView extends StatelessWidget {
//   const HabdlingDataView({super.key, required this.statuesRequest, required this.widget});
//
//   final StatuesRequest statuesRequest;
//   final Widget widget ;
//
//   @override
//   Widget build(BuildContext context) {
//     return
//
//         statuesRequest ==StatuesRequest.loadign?
//              Center(
//               child:Lottie.asset(ImageAssets.loading)
//               ,)
//             :statuesRequest ==StatuesRequest.success?
//          Center(
//             child:Lottie.asset(ImageAssets.success)
//         )
//               :statuesRequest ==StatuesRequest.serverfailure?
//          Center(
//          child:Lottie.asset(ImageAssets.failure)
//         )
//         :statuesRequest ==StatuesRequest.offlinefailure?
//          Center(
//              child:Lottie.asset(ImageAssets.noInternet)
//         ):statuesRequest ==StatuesRequest.failure?
//          Center(
//             child:Lottie.asset(ImageAssets.noData))
//             :widget;
//
//
//
//
//
//
//   }
// }
