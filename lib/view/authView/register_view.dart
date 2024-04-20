import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/custom_text_field.dart';
import 'package:rjfruits/res/components/login_container.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
          ),
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
                    "Register",
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
                    "Register to countinue",
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
                  const TextFieldCustom(
                    preIcon: Icons.email,
                    maxLines: 2,
                    text: "sfsdadf",
                    hintText: "1234@gmail.com",
                    preColor: AppColor.primaryColor,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const VerticalSpeacing(30),
                  const TextFieldCustom(
                    preIcon: Icons.lock_outline_rounded,
                    maxLines: 2,
                    text: "sfsdadf",
                    hintText: "*******",
                    preColor: AppColor.textColor1,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const VerticalSpeacing(30),
                  const TextFieldCustom(
                    preIcon: Icons.lock_outline_rounded,
                    maxLines: 2,
                    text: "sfsdadf",
                    hintText: "Re-enter Your Password",
                    preColor: Color(0xff8894A7),
                    obscureText: false,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const VerticalSpeacing(30),
                  RoundedButton(
                      title: "Register",
                      onpress: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RoutesName.dashboard, (route) => false);
                      }),
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
                        "Already have an account?",
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
                            RoutesName.login,
                          );
                        },
                        child: Text(
                          "Login",
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
    );
  }
}
