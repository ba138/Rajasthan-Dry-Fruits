import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/onboardingViews/widgets/back_container.dart';
import 'package:rjfruits/view/onboardingViews/widgets/on_button.dart';

class OnBoardingScreen2 extends StatelessWidget {
  const OnBoardingScreen2({super.key});

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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackContainer(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  InkWell(
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
                  "images/onboarding2.png",
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
                    color: AppColor.primaryColor,
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
                    color: AppColor.primaryColor,
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
                      color: AppColor.nextColor,
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
                      color: AppColor.primaryColor,
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
                progress: 0.6,
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.onboarding3);
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
