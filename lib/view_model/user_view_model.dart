import 'package:flutter/material.dart';
import 'package:rjfruits/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/google_key_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('key', user.key);
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('key');
    debugPrint(
        '.............................${token.toString()}.........................');

    return UserModel(key: token ?? '');
  }

  Future<bool> removerUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove('key');
  }

  Future<GoogleKeyModel> getgoogleUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('key');
    debugPrint('Stored Token: ${token.toString()}');

    return GoogleKeyModel(key: token ?? '');
  }
}
