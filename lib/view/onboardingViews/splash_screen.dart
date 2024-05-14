// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/colors.dart';
import '../../view_model/service/splashServicer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    splashServices.checkAuthenTication(context);
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
