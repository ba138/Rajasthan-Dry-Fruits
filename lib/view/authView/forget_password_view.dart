import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/custom_text_field.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/onboardingViews/widgets/back_container.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
              const TextFieldCustom(
                preIcon: Icons.email,
                maxLines: 2,
                text: "sfsdadf",
                hintText: "1234@gmail.com",
                preColor: AppColor.primaryColor,
              ),
              const VerticalSpeacing(30),
              RoundedButton(title: "send", onpress: () {}),
            ],
          ),
        ),
      )),
    );
  }
}
