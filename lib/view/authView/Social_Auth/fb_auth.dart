import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../utils/routes/routes_name.dart';
import '../../../utils/routes/utils.dart';

class FbAuth extends StatefulWidget {
  const FbAuth({
    super.key,
  });

  @override
  State<FbAuth> createState() => _FbAuthState();
}

class _FbAuthState extends State<FbAuth> {
  bool _isLoading = false; // Flag for loading state

  void _handleFacebookLogin(BuildContext context) async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      // Request login permissions (adjust as needed)
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'], // Request profile and email
      );

      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken!.token;
        final idToken = result.message;
        final code = result.status;
        print('Access token: $accessToken');

        // Make the POST request to your backend API
        await _handleBackendLogin(accessToken, idToken!, code.toString(),
            context); // Use await for response
      } else {
        print(result.status);
        print(result.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Facebook login failed: ${result.message}'),
          ),
        );
      }
    } catch (error) {
      print('Error logging in with Facebook: $error');

      Utils.snackBar('An error occurred. Please try again.', context);
    } finally {
      setState(() {
        _isLoading =
            false; // Hide loading indicator regardless of success/failure
      });
    }
  }

  Future<void> _handleBackendLogin(String accessToken, String idToken,
      String code, BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://103.117.180.187/api/accounts/facebook/login/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRFToken':
            'tXaYOF0LE9ZSZ1vxlr8hs2VjppvLvzN5DCBI8MjSybc1EYCU6I15cK2p0CQJTw9B',
      },
      body: jsonEncode({
        'access_token': accessToken,
        'id_token': idToken,
        'code': code,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful authentication (parse response data, navigate, etc.)
      final data = jsonDecode(response.body);
      print('Successfully logged in with Facebook! data : $data');
      Utils.toastMessage('Successfully logged in with Facebook data : $data');
      // Implement user data saving logic from response data (replace with your logic)
      // final userPrefrences = Provider.of<UserViewModel>(context, listen: false);
      // userPrefrences.saveUser(UserModel(key: data['key'].toString()));
      Navigator.pushNamed(
          context, RoutesName.dashboard); // Replace with navigation logic
    } else {
      final errorData =
          jsonDecode(response.body); // Parse error data (optional)
      print(
          'Error: ${response.statusCode} - ${errorData['message'] ?? 'Unknown error'}');
      Utils.flushBarErrorMessage(
          'Authentication failed. Please try again.', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : InkWell(
            onTap: () {
              _handleFacebookLogin(context);
            },
            child: Container(
              height: 48,
              width: 98,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColor.dividerColor.withOpacity(0.5), width: 3),
                color: const Color.fromRGBO(
                    255, 255, 255, 0.2), // Background color with opacity
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5), // Shadow color
                    blurRadius: 2, // Blur radius
                    spreadRadius: 0, // Spread radius
                    offset: const Offset(0, 0), // Offset
                  ),
                ],
              ),
              child: Image.asset(
                "images/fb.png",
                height: 24,
                width: 24,
              ),
            ),
          );
  }
}
