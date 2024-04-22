import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view_model/user_view_model.dart';

import '../../model/user_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthenTication(BuildContext context) {
    getUserData().then((value) {
      if (value.key.isEmpty || value.key == '') {
        Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        Future.delayed(const Duration(seconds: 5));
        Navigator.pushNamed(context, RoutesName.dashboard);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
