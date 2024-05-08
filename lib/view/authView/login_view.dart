import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/custom_text_field.dart';
import 'package:rjfruits/res/components/loading_manager.dart';
import 'package:rjfruits/res/components/login_container.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';

import '../../utils/routes/utils.dart';
import '../../view_model/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppColor.whiteColor,
            image: DecorationImage(
                image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
          ),
          child: LoadingManager(
            isLoading: _isLoading,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpeacing(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                      "Insert your credientls to login",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.textColor1,
                        ),
                      ),
                    ),
                    const VerticalSpeacing(36),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFieldCustom(
                            controller: nameController,
                            preIcon: Icons.email,
                            maxLines: 2,
                            text: "sfsdadf",
                            hintText: "name",
                            preColor: AppColor.primaryColor,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const VerticalSpeacing(30),
                          TextFieldCustom(
                            controller: emailController,
                            preIcon: Icons.email,
                            maxLines: 2,
                            text: "sfsdadf",
                            hintText: "1234@gmail.com",
                            preColor: AppColor.primaryColor,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const VerticalSpeacing(30),
                          TextFieldCustom(
                            controller: passwordController,
                            preIcon: Icons.lock_outline_rounded,
                            maxLines: 2,
                            text: "sfsdadf",
                            hintText: "*******",
                            preColor: AppColor.textColor1,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const VerticalSpeacing(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.forget,
                                  );
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: GoogleFonts.getFont(
                                    "Poppins",
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const VerticalSpeacing(30),
                          _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : RoundedButton(
                                  title: "Login",
                                  onpress: () {
                                    if (emailController.text.isEmpty) {
                                      Utils.flushBarErrorMessage(
                                          'please enter your email', context);
                                    } else if (passwordController
                                        .text.isEmpty) {
                                      Utils.flushBarErrorMessage(
                                          'please enter your password',
                                          context);
                                    } else if (passwordController.text.length <
                                        4) {
                                      Utils.flushBarErrorMessage(
                                          'plase enter more than four digits',
                                          context);
                                    } else {
                                      Map<String, String> data = ({
                                        'username':
                                            nameController.text.toString(),
                                        'email':
                                            emailController.text.toString(),
                                        'password':
                                            passwordController.text.toString(),
                                      });
                                      authViewModel.loginApi(data, context);
                                    }
                                  }),
                        ],
                      ),
                    ),
                    const VerticalSpeacing(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Or, login with...",
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textColor1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const VerticalSpeacing(20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoginContainer(
                          img: "images/google.png",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        LoginContainer(
                          img: "images/fb.png",
                        ),
                      ],
                    ),
                    const VerticalSpeacing(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textColor1,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.register,
                            );
                          },
                          child: Text(
                            "Register",
                            style: GoogleFonts.getFont(
                              "Poppins",
                              textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
