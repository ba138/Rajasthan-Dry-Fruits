import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void startTimer() {
    Timer(const Duration(seconds: 6), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.onboarding1,
        (route) => false,
      );
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
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
              image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Image.asset(
            "images/logo.png",
            height: 75,
            width: 205,
          ),
        ),
      )),
    );
  }
}
