import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rjfruits/utils/routes/utils.dart';

import '../../utils/routes/routes_name.dart';
import '../user_view_model.dart';

class AuthService {
  Future<void> logout(BuildContext context) async {
    try {
      final userPreferences =
          Provider.of<UserViewModel>(context, listen: false);
      final userModel = await userPreferences.getUser();
      final token = userModel.key;

      final response = await http.post(
        Uri.parse('http://103.117.180.187/rest-auth/logout/'),
        headers: {
          'accept': 'application/json',
          'authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        Utils.toastMessage('Successfully Logout');
        userPreferences.removerUser();
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        Utils.toastMessage('Logout Failed');
      }
    } catch (e) {
      Utils.toastMessage('Error during logout: $e');
    }
  }
}
