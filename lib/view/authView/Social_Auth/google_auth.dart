import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../../../model/google_auth_model.dart';
import '../../../utils/routes/routes_name.dart';
import '../../../utils/routes/utils.dart';

// Import your GoogleAuthModel here

class GoogleAuthButton extends StatefulWidget {
  const GoogleAuthButton({super.key});

  @override
  State<GoogleAuthButton> createState() => _GoogleAuthButtonState();
}

class _GoogleAuthButtonState extends State<GoogleAuthButton> {
  bool _isLoading = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email', // Request basic profile information (email is common)
      // Add other required scopes based on your API needs
    ],
  );

  Future<void> _authenticateWithGoogle(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Step 1: Start the Google sign-in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Step 2: Obtain the auth token
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Step 3: Prepare the request body using GoogleAuthModel
      final GoogleAuthModel authData = GoogleAuthModel(
        accessToken: googleAuth.accessToken.toString(),
        code: 'string', // Set code if required by your API
        idToken: googleAuth.idToken.toString(),
      );

      // Step 4: Make a POST request to your API endpoint
      final response = await http.post(
        Uri.parse('http://103.117.180.187/api/accounts/google/login/'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'X-CSRFToken':
              'tXaYOF0LE9ZSZ1vxlr8hs2VjppvLvzN5DCBI8MjSybc1EYCU6I15cK2p0CQJTw9B',
        },
        body: googleAuthModelToJson(authData),
      );

      // Step 5: Handle the response from your backend
      if (response.statusCode == 200) {
        // Authentication successful
        final data = jsonDecode(response.body);
        print('Successfully logged in with Google!');
        Utils.toastMessage('Successfully logged in with Google');
        // Implement user data saving logic from response data (replace with your logic)
        // final userPreferences = Provider.of<UserViewModel>(context, listen: false);
        // userPreferences.saveUser(UserModel(key: data['key'].toString()));
        Navigator.pushNamed(context, RoutesName.dashboard);
      } else {
        // Authentication failed
        final errorData = jsonDecode(response.body);
        print(
            'Error: ${response.statusCode} - ${errorData['message'] ?? 'Unknown error'}');
        Utils.flushBarErrorMessage(
            'Authentication failed. Please try again.', context);
      }
    } catch (error) {
      // Handle sign-in errors
      print('Error signing in with Google: $error');
      Utils.flushBarErrorMessage(
          'Error signing in with Google: $error', context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!_isLoading) {
          _authenticateWithGoogle(context);
        }
      },
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: 48,
              width: 98,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: Colors.grey.withOpacity(0.5), width: 3),
                color: const Color.fromRGBO(255, 255, 255, 0.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    blurRadius: 2,
                    spreadRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Image.asset(
                "images/google.png",
                height: 24,
                width: 24,
              ),
            ),
    );
  }
}
