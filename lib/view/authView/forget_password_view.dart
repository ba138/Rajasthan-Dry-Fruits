// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/custom_text_field.dart';
import 'package:rjfruits/res/components/loading_manager.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/onboardingViews/widgets/back_container.dart';
import 'package:http/http.dart' as http;

import '../../utils/routes/utils.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool _isLoading = false;
  final _emailController = TextEditingController();

  Future<void> sendPasswordResetRequest(String email) async {
    setState(() {
      _isLoading = true;
    });
    try {
      // final userPreferences =
      //     Provider.of<UserViewModel>(context, listen: false);
      // final userModel = await userPreferences.getUser();
      // final token = userModel.key;
      final url = Uri.parse(
          'http://103.117.180.187/rest-auth/registration/resend-email/');

      final response = await http.post(
        url,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'X-CSRFToken':
              'Heojc4dezP2iHfqRHAG41VUOr0dQEFj0RTP3wbwltRfrmcxesRzSLD1U2dyO2CFw',
        },
        body: jsonEncode({'email': email}),
      );

      print('API Response: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        // Password reset email sent successfully
        Utils.toastMessage('Password reset email has been sent.');
        setState(() {
          _isLoading = false;
        });
      } else {
        // Handle API errors
        Utils.toastMessage('An error occurred. Please try again later.');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle network or unexpected errors
      print('Error sending password reset request: $e');
      Utils.toastMessage(
          'An error occurred. Please try again later. Network error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          image: DecorationImage(
            image: AssetImage("images/bgimg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: LoadingManager(
          isLoading: _isLoading,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpeacing(20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackContainer(
                      color: Color(0xffEEEEEE),
                      iconColor: AppColor.textColor1,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                    Image.asset(
                      "images/logo.png",
                      height: 38,
                      width: 107,
                    ),
                  ],
                ),
                const VerticalSpeacing(30),
                Text(
                  "Hello!",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
                Text(
                  "Enter your email addreess then we will send\n you a code to reset your password",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor1,
                    ),
                  ),
                ),
                const VerticalSpeacing(36),
                TextFieldCustom(
                  controller: _emailController,
                  preIcon: Icons.email,
                  maxLines: 2,
                  text: "sfsdadf",
                  hintText: "1234@gmail.com",
                  preColor: AppColor.primaryColor,
                  keyboardType: TextInputType.emailAddress,
                ),
                const VerticalSpeacing(30),
                RoundedButton(
                    title: "send",
                    onpress: () async {
                      try {
                        await sendPasswordResetRequest(_emailController.text);
                      } catch (e) {
                        Utils.flushBarErrorMessage(
                            'error while forget password $e', context);
                      }
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
