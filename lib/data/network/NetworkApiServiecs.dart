// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart';
// import 'package:mvvm/data/app_excenptions.dart';
// import 'package:mvvm/data/network/BaseApiservices.dart';
// import 'package:http/http.dart' as http;
// import 'package:rj_dryfruit/data/app_excenptions.dart';
// import 'package:rj_dryfruit/data/network/BaseApiServices.dart';

// class NetworkApiService extends BaseApiServices {
//   @override
//   Future getGetApiResponse(String url) async {
//     dynamic responseJson;
//     try {
//       final response =
//           await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
//       responseJson = returnResponseJson(response);
//     } on SocketException {
//       throw FetchDataException('No Internet Connection');
//     }
//     return responseJson;
//   }

//   @override
//   Future getPostApiResponse(String url, dynamic data) async {
//     dynamic responseJson;
//     try {
//       Response response = await post(
//         Uri.parse(url),
//         body: data,
//       ).timeout(const Duration(seconds: 10));
//       responseJson = returnResponseJson(response);
//     } on SocketException {
//       throw FetchDataException('No Internet Connection');
//     }
//     return responseJson;
//   }

//   dynamic returnResponseJson(http.Response response) {
//     switch (response.statusCode) {
//       case 200:
//         dynamic responseJson = jsonDecode(response.body);
//         return responseJson;
//       case 400:
//         return (response.body.toString());
//       default:
//         throw FetchDataException(
//             'Error occure while communicating with server ' +
//                 'with statis code' +
//                 response.statusCode.toString());
//     }
//   }
// }
