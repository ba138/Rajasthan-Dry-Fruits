// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:mvvm/model/user_model.dart';
// import 'package:mvvm/utils/routes/routes_name.dart';
// import 'package:mvvm/view_model/user_view_model.dart';

// class SplashServices {
//   Future<UserModel> getUserData() => UserViewModel().getUser();

//   void checkAuthenTication(BuildContext context) {
//     getUserData().then((value) {
//       if (value.token.isEmpty || value.token == '') {
//         Future.delayed(const Duration(seconds: 3));
//         Navigator.pushNamed(context, RoutesName.login);
//       } else {
//         Future.delayed(const Duration(seconds: 5));
//         Navigator.pushNamed(context, RoutesName.home);
//       }
//     }).onError((error, stackTrace) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     });
//   }
// }
