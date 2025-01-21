
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ersei/app/core/class/statusrequest.dart';
import 'package:ersei/app/core/functions/checkinternetconnected.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    try {
      if (await checkInternet()) {
        print('Sending POST request to: $linkurl');
        print('With data: $data');

        var response = await http.post(
          Uri.parse(linkurl),
          body: data,
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          print('Server error: ${response.statusCode}');
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        print('No internet connection');
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      print('Exception occurred: $e');
      return const Left(StatusRequest.serverException);
    }
  }
}


// import 'dart:convert';
//
// import 'package:dartz/dartz.dart';
// import 'package:ersei/app/core/class/statusrequest.dart';
// import 'package:ersei/app/core/functions/checkinternetconnected.dart';
// import 'package:http/http.dart' as http;
//
// class Crud{
//
//   Future<Either<StatusRequest,Map>> postData(String linkurl ,Map data) async {
//    try{
//      if (await checkInternet()){
//
//        var response = await http.post(Uri.parse(linkurl),body:data);
//        if(response.statusCode==200 || response.statusCode==201){
//          Map responsebody = jsonDecode(response.body);
//          print('this is response from crud $responsebody');
//          return Right(responsebody);
//
//        } else {
//
//          return const Left(StatusRequest.serverfailure);
//        }
//
//      }else {
//
//        return const Left(StatusRequest.offlinefailure);
//      }
//
//    }catch(_){
//      return const Left(StatusRequest.serverException);
//    }
//
//   }
//
// }