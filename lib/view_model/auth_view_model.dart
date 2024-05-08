import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/view_model/user_view_model.dart';

import '../model/user_model.dart';
import '../repository/auth_repository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/routes/utils.dart';
import 'package:dio/dio.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _isLoading = false;
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

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

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

      setLoading(false);
      Utils.toastMessage('Successfully Logged In');
      Navigator.pushNamed(context, RoutesName.dashboard);

      if (kDebugMode) {
        print(response.toString());
      }
    } on DioError catch (error) {
      Utils.flushBarErrorMessage(handleError(error), context);
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    } catch (error) {
      Utils.flushBarErrorMessage('An unexpected error occurred.', context);
      setLoading(false);
    }
  }

  Future<void> signUpApi(Map<String, String> data, BuildContext context) async {
    setSignUpLaoding(true);
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

      setSignUpLaoding(false);
      Utils.toastMessage('Successfully Registered');
      Navigator.pushNamed(context, RoutesName.dashboard);
      final userPrefrences = Provider.of<UserViewModel>(context, listen: false);
      userPrefrences.saveUser(UserModel(key: response.data['key'].toString()));
      if (kDebugMode) {
        print(response.toString());
      }
    } on DioError catch (error) {
      Utils.flushBarErrorMessage(handleError(error), context);
      setSignUpLaoding(false);
      if (kDebugMode) {
        print(error.toString());
      }
    } catch (error) {
      // Handle other non-DioError exceptions
      Utils.flushBarErrorMessage(
          'An unexpected error occurred: $error.', context);
      setSignUpLaoding(false);
    }
  }

  String handleError(DioError error) {
    // Implement logic to handle different DioError types and return appropriate messages
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return 'Connection timed out. Please check your internet connection.';
      case DioErrorType.badResponse:
        // Handle server-side errors (e.g., check error codes or response data)
        return error.response!.data['message'] ??
            'An error occurred:${error.response} ';
      case DioErrorType.cancel:
        return 'Request cancelled.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
