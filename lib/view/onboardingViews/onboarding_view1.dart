import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/onboardingViews/widgets/on_button.dart';

class OnBoardingScreen1 extends StatelessWidget {
  const OnBoardingScreen1({super.key});

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
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RoutesName.login, (route) => false);
                      },
                      child: Text(
                        "Skip",
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                VerticalSpeacing(MediaQuery.of(context).size.height / 50),
                Center(
                  child: Image.asset(
                    "images/onboarding1.png",
                    height: 321,
                    width: 321,
                  ),
                ),
                Text(
                  "Quick and easy \ndelivery",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColor.textColor1,
                    ),
                  ),
                ),
                VerticalSpeacing(MediaQuery.of(context).size.height / 24),
                Text(
                  "Easy and fast learning at \nany time to help you\nimprove various skills",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor1,
                    ),
                  ),
                ),
                VerticalSpeacing(MediaQuery.of(context).size.height / 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColor.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 5,
                      width: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColor.nextColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 5,
                      width: 9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColor.nextColor,
                      ),
                    ),
                  ],
                ),
                VerticalSpeacing(MediaQuery.of(context).size.height / 24),
                OnButton(
                  progress: 0.3,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.onboarding2);
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
