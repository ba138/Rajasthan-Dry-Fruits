import 'package:flutter/material.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/onboardingViews/onboarding_view1.dart';
import 'package:rjfruits/view/onboardingViews/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RoutesName.onboarding1:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnBoardingScreen1());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No routes define'),
            ),
          );
        });
    }
  }
}
