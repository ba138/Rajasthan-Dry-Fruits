import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/google_auth_model.dart';
import '../../../res/components/colors.dart';
import '../../../utils/routes/routes_name.dart';
import '../../../utils/routes/utils.dart';

class GoogleAuthButton extends StatefulWidget {
  const GoogleAuthButton({super.key});

  @override
  State<GoogleAuthButton> createState() => _GoogleAuthButtonState();
}

class _GoogleAuthButtonState extends State<GoogleAuthButton> {
  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   clientId:
  //       '176072233182-hhg6ae8thrbu73eeukr7rd51el9iugec.apps.googleusercontent.com',
  //   scopes: [
  //     'email',
  //     'profile',
  //     'openid',
  //   ],
  // );

  // bool _isLoading = false;

  Future<void> afterLoginSuccess(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', key);
  }

  // void setLoading(bool value) {
  //   setState(() {
  //     _isLoading = value;
  //   });
  // }

  // Future<void> _authenticateWithGoogle(BuildContext context) async {
  //   setLoading(true);

  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  //     if (googleUser == null) {
  //       setLoading(false);
  //       return;
  //     }

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //     debugPrint('Access Token: ${googleAuth.accessToken}');
  //     debugPrint('ID Token: ${googleAuth.idToken}');

  //     final Map<String, String> authData = {
  //       'access_token': googleAuth.accessToken ?? '',
  //       'code': '',
  //       'id_token': googleAuth.idToken ?? '',
  //     };

  //     final response = await http.post(
  //       Uri.parse('http://103.117.180.187/api/accounts/google/login/'),
  //       headers: {
  //         'accept': 'application/json',
  //         'Content-Type': 'application/json',
  //         'X-CSRFToken':
  //             '7X8yHQkwHc5IjVH5xZXk41gEzjg2EKQJU1WGKNebZinArN2t54gpSmKrA4HQA1gM',
  //       },
  //       body: jsonEncode(authData),
  //     );

  //     debugPrint('Response Status: ${response.statusCode}');
  //     debugPrint('Response Body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       try {
  //         final responseBody = json.decode(response.body);
  //         String? userKey = responseBody['key'];

  //         if (userKey != null && userKey.isNotEmpty) {
  //           await afterLoginSuccess(userKey);
  //           Utils.toastMessage('Successfully logged in with Google');
  //           Navigator.pushReplacementNamed(context, RoutesName.dashboard);
  //         } else {
  //           throw Exception('Token is missing in the response');
  //         }
  //       } catch (e) {
  //         debugPrint('Error decoding response: $e');
  //         Utils.flushBarErrorMessage('Error decoding response: $e', context);
  //       }
  //     } else {
  //       _handleErrorResponse(response, context);
  //     }
  //   } catch (error) {
  //     debugPrint('Error signing in with Google: $error');
  //     Utils.flushBarErrorMessage(
  //         'Error signing in with Google: $error', context);
  //   } finally {
  //     setLoading(false);
  //   }
  // }

  // void _handleErrorResponse(http.Response response, BuildContext context) {
  //   debugPrint('Failed Response Body: ${response.body}');
  //   if (response.headers['content-type']?.contains('application/json') ==
  //       true) {
  //     try {
  //       final errorData = json.decode(response.body);
  //       Utils.flushBarErrorMessage(
  //         'Failed to login with Google: ${response.statusCode} - ${errorData['message'] ?? 'Unknown error'}',
  //         context,
  //       );
  //     } catch (e) {
  //       debugPrint('Error decoding error response: $e');
  //       Utils.flushBarErrorMessage(
  //         'Failed to login with Google: ${response.statusCode} - Unexpected error format',
  //         context,
  //       );
  //     }
  //   } else {
  //     Utils.flushBarErrorMessage(
  //       'Failed to login with Google: ${response.statusCode} - Non-JSON response received',
  //       context,
  //     );
  //   }
  // }
  bool _isLoading = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'openid',
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
      debugPrint('access Token:${googleAuth.accessToken}');
      debugPrint('Id Token:${googleAuth.idToken}');

      // Step 3: Prepare the request body using GoogleAuthModel
      final GoogleAuthModel authData = GoogleAuthModel(
        accessToken: googleAuth.accessToken.toString(),
        code: 'string',
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
      debugPrint('Status code:${response.statusCode}');
      // Step 5: Handle the response from your backend
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        String? userKey = responseBody['token'];

        if (userKey != null && userKey.isNotEmpty) {
          await afterLoginSuccess(userKey);
          Utils.toastMessage('Successfully logged in with Google');
          Navigator.pushReplacementNamed(context, RoutesName.dashboard);
        } else {
          throw Exception('Token is missing in the response');
        }
        // Authentication successful
        Utils.toastMessage('Successfully logged in with Google');
        // Implement user data saving logic from response data (replace with your logic)
        // final userPreferences = Provider.of<UserViewModel>(context, listen: false);
        // userPreferences.saveUser(UserModel(key: data['key'].toString()));
        Navigator.pushNamed(context, RoutesName.dashboard);
      } else {
        // Authentication failed
        final errorData = jsonDecode(response.body);
        debugPrint(
            'Error: ${response.statusCode} - ${errorData['message'] ?? 'Unknown error'}');
        Utils.flushBarErrorMessage(
            'Authentication failed. Please try again.', context);
      }
    } catch (error) {
      // Handle sign-in errors
      debugPrint('Error signing in with Google: $error');
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
      onTap: () async {
        await _authenticateWithGoogle(context);
      },
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: 48,
              width: double.infinity,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/google.png",
                      height: 28,
                      width: 28,
                    ),
                    const SizedBox(width: 20.0),
                    Text(
                      "Continue with Google",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.textColor1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
