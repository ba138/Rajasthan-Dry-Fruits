import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../res/components/colors.dart';
import '../../../utils/routes/routes_name.dart';
import '../../../utils/routes/utils.dart';

class GoogleAuthButton extends StatefulWidget {
  const GoogleAuthButton({super.key});

  @override
  State<GoogleAuthButton> createState() => _GoogleAuthButtonState();
}

class _GoogleAuthButtonState extends State<GoogleAuthButton> {
  bool _isLoading = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'openid',
    ],
  );

  // Future<void> _authenticateWithGoogle(BuildContext context) async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     // Step 1: Start the Google sign-in process
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  //     if (googleUser == null) {
  //       // User cancelled the sign-in
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       return;
  //     }

  //     // Step 2: Obtain the auth token
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //     debugPrint('Access Token: ${googleAuth.accessToken}');
  //     debugPrint('ID Token: ${googleAuth.idToken}');

  //     // Step 3: Prepare the request body using GoogleAuthModel
  //     final GoogleAuthModel authData = GoogleAuthModel(
  //       accessToken: googleAuth.accessToken.toString(),
  //       code: 'string',
  //       idToken: googleAuth.idToken.toString(),
  //     );
  //     // final userPreferences =
  //     //     Provider.of<UserViewModel>(context, listen: false);
  //     // final userModel = await userPreferences.getgoogleUser();
  //     // final token = userModel.key;

  //     // Step 4: Make a POST request to your API endpoint
  //     final response =
  //      await http.post(
  //       Uri.parse('http://103.117.180.187/api/accounts/google/login/'),
  //       headers: {
  //         'accept': 'application/json',
  //         'Content-Type': 'application/json',
  //         'access_token': googleAuth.accessToken.toString(),
  //       },
  //       body: googleAuthModelToJson(authData),
  //     );
  //     debugPrint('Status code: ${response.statusCode}');
  //     debugPrint('Response body: ${response.body}');

  //     // Step 5: Handle the response from your backend
  //     if (response.statusCode == 200) {
  //       print('username: ${googleUser.displayName}');
  //       print('email: ${googleUser.email}');

  //       final responseBody = await json.decode(json.encode(response.body));
  //       String? userKey = responseBody['key'];
  //       debugPrint('user key: $userKey');

  //       if (userKey != null && userKey.isNotEmpty) {
  //         await afterLoginSuccess(userKey);
  //         Utils.toastMessage('Successfully logged in with Google');
  //         Navigator.pushReplacementNamed(context, RoutesName.dashboard);
  //       } else {
  //         throw Exception('Token is missing in the response');
  //       }
  //     } else {
  //       // Authentication failed
  //       final errorData = jsonDecode(utf8.decode(response.bodyBytes));
  //       debugPrint(
  //           'Error: ${response.statusCode} - ${errorData['message'] ?? 'Unknown error'}');
  //       Utils.flushBarErrorMessage(
  //           'Authentication failed. Please try again.', context);
  //     }
  //   } catch (error) {
  //     // Handle sign-in errors
  //     debugPrint('Error signing in with Google: $error');
  //     Utils.flushBarErrorMessage(
  //         'Error signing in with Google: $error', context);
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  Future<void> afterLoginSuccess(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('key', key);
  }

  Future<void> handleSignOut() => _googleSignIn.disconnect();

  Future<void> handleGoogleSignIn(BuildContext context) async {
    handleSignOut();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final String accessToken = googleSignInAuthentication.accessToken ?? '';
        final String idToken = googleSignInAuthentication.idToken ?? '';

        Utils.toastMessage('$idToken $accessToken');
        handleGoogleLoginServer(context, accessToken, idToken);
      }
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
      debugPrint('error mesg: $error');
    }
  }

  Future<void> handleGoogleLoginServer(
      BuildContext context, String accessToken, String idToken) async {
    Map data = {'access_token': accessToken, 'code': '', 'id_token': idToken};

    _isLoading = true;
    try {
      var response = await http.post(
        Uri.parse('http://103.117.180.187/api/accounts/google/login/'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'access_token': accessToken,
        },
        body: jsonEncode(data),
      );
      await afterLoginSuccess(response.body);
      debugPrint('response: ${response.statusCode}');

      _isLoading = false;
      Navigator.pushReplacementNamed(context, RoutesName.dashboard);
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
      debugPrint('error mesg: $error');
    } finally {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await handleGoogleSignIn(context);
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
