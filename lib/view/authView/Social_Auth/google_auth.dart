import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../../../utils/routes/routes_name.dart';
import '../../../utils/routes/utils.dart';
import '../../../view_model/user_view_model.dart';

class GoogleAuthButton extends StatefulWidget {
  const GoogleAuthButton({Key? key}) : super(key: key);

  @override
  State<GoogleAuthButton> createState() => _GoogleAuthButtonState();
}

class _GoogleAuthButtonState extends State<GoogleAuthButton> {
  bool _isLoading = false;

  Future<void> _authenticateWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
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
      final userPreferences =
          Provider.of<UserViewModel>(context, listen: false);
      final userModel = await userPreferences.getUser();
      final token = userModel.key;
      print(
          '..........................${googleAuth.accessToken}...............');
      print('..........................${googleAuth.idToken}...............');

      // Step 3: Make a POST request to your API endpoint with the token
      final response = await http.post(
        Uri.parse('http://103.117.180.187/api/accounts/google/login/'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'authorization': 'Token $token',
        },
        body: jsonEncode({
          'access_token': googleAuth.accessToken,
          'id_token': googleAuth.idToken,
          // Optionally include other data required by your API
        }),
      );
      print(
          '.............................${response.statusCode}.......................');
      // Step 4: Handle the response
      if (response.statusCode == 200) {
        print(
            '..........................${googleAuth.accessToken}...............');
        print('..........................${googleAuth.idToken}...............');

        Utils.toastMessage('Successfully loggedIn with google');
        // final userPrefrences =
        //     Provider.of<UserViewModel>(context, listen: false);

        // userPrefrences
        //     .saveUser(UserModel(key: response.data['key'].toString()));
        Navigator.pushNamed(context, RoutesName.dashboard);
      } else {
        print(
            '..........................${googleAuth.accessToken}...............');
        print('..........................${googleAuth.idToken}...............');

        Utils.flushBarErrorMessage(
            'Error occure please try again later', context);
      }
    } catch (error) {
      // Handle sign-in errors (e.g., network issues)

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
      onTap: () => _isLoading ? null : _authenticateWithGoogle(context),
      child: Container(
        height: 48,
        width: 98,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 3),
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
