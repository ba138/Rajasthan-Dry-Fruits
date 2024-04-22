// import 'package:mvvm/data/network/BaseApiservices.dart';
// import '../data/network/NetworkApiServiecs.dart';
// import '../res/app_url.dart';

// class AuthRepository {
//   final BaseApiServices _apiServices = NetworkApiService();

//   Future<dynamic> loginApi(dynamic data) async {
//     try {
//       dynamic response =
//           await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
//       return response;
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<dynamic> signUpApi(dynamic data) async {
//     try {
//       dynamic response =
//           await _apiServices.getPostApiResponse(AppUrl.registerEndPoint, data);
//       return response;
//     } catch (e) {
//       throw e;
//     }
//   }
// }
