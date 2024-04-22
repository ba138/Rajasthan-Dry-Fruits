// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:mvvm/repository/auth_repository.dart';
// import 'package:mvvm/utils/routes/routes.dart';
// import 'package:mvvm/utils/routes/utils.dart';

// import '../utils/routes/routes_name.dart';

// class AuthViewModel with ChangeNotifier {
//   final _myRepo = AuthRepository();
//   bool _isLoading = false;
//   bool get isloading => _isLoading;
//   void setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   bool _signupLoading = false;
//   bool get signupLoading => _signupLoading;

//   void setSignUpLaoding(bool value) {
//     _signupLoading = value;
//     notifyListeners();
//   }

//   Future<void> loginApi(dynamic data, BuildContext context) async {
//     setLoading(true);
//     _myRepo.loginApi(data).then((value) {
//       setLoading(false);
//       Utils.flushBarErrorMessage(value.toString(), context);
//       Navigator.pushNamed(context, RoutesName.home);
//       if (kDebugMode) {
//         print(value.toString());
//       }
//     }).onError((error, stackTrace) {
//       Utils.flushBarErrorMessage(error.toString(), context);
//       setLoading(false);
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     });
//   }

//   Future<void> signUpApi(dynamic data, BuildContext context) async {
//     setSignUpLaoding(true);
//     _myRepo.loginApi(data).then((value) {
//       setSignUpLaoding(false);
//       Utils.flushBarErrorMessage(value.toString(), context);
//       Navigator.pushNamed(context, RoutesName.login);

//       if (kDebugMode) {
//         print(value.toString());
//       }
//     }).onError((error, stackTrace) {
//       Utils.flushBarErrorMessage(error.toString(), context);
//       setSignUpLaoding(false);
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     });
//   }
// }
