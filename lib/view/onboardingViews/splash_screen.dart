// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';

import '../../view_model/auth_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void startSessionCheck() {
    // Start a timer with a 6-second delay
    Timer(const Duration(seconds: 6), () {
      Navigator.pushNamed(context, RoutesName.onboarding1);
      checkSession();
    });
  }

  Future<void> checkSession() async {
    bool isLoggedIn = await SessionManager.isLoggedIn();
    Navigator.pushReplacementNamed(
      context,
      isLoggedIn ? RoutesName.dashboard : RoutesName.onboarding1,
    );
  }

  @override
  void initState() {
    startSessionCheck();
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
