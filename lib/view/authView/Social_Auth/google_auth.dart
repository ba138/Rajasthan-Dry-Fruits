import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../model/user_model.dart';
import '../../../res/components/colors.dart';
import '../../../utils/routes/routes_name.dart';
import '../../../utils/routes/utils.dart';
import '../../../view_model/user_view_model.dart';

class GoogleAuthButton extends StatefulWidget {
  const GoogleAuthButton({super.key});

  @override
  State<GoogleAuthButton> createState() => _GoogleAuthButtonState();
}

class _GoogleAuthButtonState extends State<GoogleAuthButton> {
  bool _isLoading = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '176072233182-hhg6ae8thrbu73eeukr7rd51el9iugec.apps.googleusercontent.com',
    scopes: [
      'email',
      'profile',
      'openid',
    ],
  );
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
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        String key = responseBody['key'].toString();
        final userPrefrences =
            Provider.of<UserViewModel>(context, listen: false);
        userPrefrences.saveUser(UserModel(key: key));
        Utils.toastMessage('SuccessFully SignIn');
        Navigator.pushReplacementNamed(context, RoutesName.dashboard);

        _isLoading = false;
      } else {
        _isLoading = false;
        Utils.flushBarErrorMessage('Login Failed', context);
      }
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
