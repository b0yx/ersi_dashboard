import '../class/statusrequest.dart';

StatusRequest handlingData(response) {
  if (response is StatusRequest) {
    print('this is response from handlingData: $response');
    return response;
  } else {
    return StatusRequest.success; // تأكد من إعادة StatusRequest.success عند نجاح الجلب
  }
}



// import '../class/statusrequest.dart';
//
// handlingData(response){
//
//   if(response is StatusRequest){
//     print('this is response from handlingdata $response');
//     return response;
//   }else {
//     StatusRequest.success;
//   }
//
// }