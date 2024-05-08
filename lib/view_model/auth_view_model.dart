import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/model/user_model.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:rjfruits/view_model/user_view_model.dart';

import '../repository/auth_repository.dart';
import '../utils/routes/routes_name.dart';

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
    await _myRepo.loginApi(data).then((value) {
      setLoading(false);
      Utils.toastMessage('Successfully Login');

      Navigator.pushNamed(context, RoutesName.dashboard);
      final userPrefrences = Provider.of<UserViewModel>(context, listen: false);

      userPrefrences.saveUser(UserModel(key: value['key'].toString()));
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLaoding(true);
    await _myRepo.signUpApi(data).then((value) {
      setSignUpLaoding(false);
      Utils.toastMessage('Successfully Register');
      Navigator.pushNamed(context, RoutesName.dashboard);
      final userPrefrences = Provider.of<UserViewModel>(context, listen: false);

      userPrefrences.saveUser(UserModel(key: value['key'].toString()));

      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      setSignUpLaoding(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
