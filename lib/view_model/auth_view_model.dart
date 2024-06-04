// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/view_model/user_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
import '../utils/routes/routes_name.dart';
import '../utils/routes/utils.dart';

class AuthViewModel with ChangeNotifier {
  // final _myRepo = AuthRepository();

  bool get isloading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _signupLoading = false;
  bool get signupLoading => _signupLoading;

  void setSignUpLaoding(bool value) {
    _signupLoading = value;
    notifyListeners();
  }

  bool _isLoading = false;

  Future<void> loginApi(dynamic data, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final dio = Dio();

      final headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRFToken':
            ' XjM64o8umW9Tog5kpUyPTyZg3hW4OoXupvilLAmzvFfATCjQrBGe2cN89tPjxsKm',
      };

      final response = await dio.post(
        'http://103.117.180.187/rest-auth/login/',
        options: Options(headers: headers),
        data: data,
      );

      _isLoading = false;
      Utils.toastMessage('Successfully Logged In');
      await SessionManager.setLoggedIn(true);
      final userPrefrences = Provider.of<UserViewModel>(context, listen: false);
      userPrefrences.saveUser(UserModel(key: response.data['key'].toString()));
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.dashboard, (route) => false);

      if (kDebugMode) {
        print(response.toString());
      }
    } on DioError catch (error) {
      Utils.flushBarErrorMessage(handleError(error), context);
      debugPrint(' auth View Error: $error');
      _isLoading = false;
      if (kDebugMode) {
        print(error.toString());
        debugPrint(' auth View Error: $error');
      }
    } catch (error) {
      Utils.flushBarErrorMessage('An unexpected error occurred.', context);
      debugPrint(' auth View catch: $error');
      _isLoading = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUpApi(Map<String, String> data, BuildContext context) async {
    _isLoading = true;
    try {
      final dio = Dio();
      final headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRFToken':
            'XjM64o8umW9Tog5kpUyPTyZg3hW4OoXupvilLAmzvFfATCjQrBGe2cN89tPjxsKm',
      };

      final response = await dio.post(
        'http://103.117.180.187/rest-auth/registration/',
        options: Options(headers: headers),
        data: data,
      );

      _isLoading = false;
      Utils.toastMessage('Successfully Registered');
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.login, (route) => false);

      if (kDebugMode) {
        print(response.toString());
      }
    } on DioError catch (error) {
      Utils.flushBarErrorMessage(handleError(error), context);
      _isLoading = false;
      if (kDebugMode) {
        print(error.toString());
      }
    } catch (error) {
      // Handle other non-DioError exceptions
      Utils.flushBarErrorMessage(
          'An unexpected error occurred: $error.', context);
      _isLoading = false;
    }
  }

  String handleError(DioError error) {
    // Implement logic to handle different DioError types and return appropriate messages
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return 'Connection timed out. Please check your internet connection.';
      case DioErrorType.badResponse:
        // Handle server-side errors (e.g., check error codes or response data)
        return 'Invalid credentails';

      case DioErrorType.cancel:
        return 'Request cancelled.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}

class SessionManager {
  static const _keyLoggedIn = 'isLoggedIn';

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLoggedIn) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, value);
  }
}
