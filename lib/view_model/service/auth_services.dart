import 'package:http/http.dart' as http;
import 'package:rjfruits/utils/routes/utils.dart';

class AuthService {
  Future<void> logout(String csrfToken) async {
    try {
      final response = await http.post(
        Uri.parse('http://103.117.180.187/rest-auth/logout/'),
        headers: {
          'accept': 'application/json',
          'X-CSRFToken': csrfToken,
        },
      );

      if (response.statusCode == 200) {
        Utils.toastMessage('Successfully Logout');
      } else {
        Utils.toastMessage('Logout Failed');
      }
    } catch (e) {
      Utils.toastMessage('Error during logout: $e');
    }
  }
}
