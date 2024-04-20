import 'package:flutter/material.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/HomeView/home_view.dart';
import 'package:rjfruits/view/authView/forget_password_view.dart';
import 'package:rjfruits/view/authView/login_view.dart';
import 'package:rjfruits/view/bestSellersView/best_sellers.dart';
import 'package:rjfruits/view/dashBoard/dashboard.dart';
import 'package:rjfruits/view/authView/register_view.dart';
import 'package:rjfruits/view/onboardingViews/onboarding_view1.dart';
import 'package:rjfruits/view/onboardingViews/onboarding_view2.dart';
import 'package:rjfruits/view/onboardingViews/onboarding_view3.dart';
import 'package:rjfruits/view/onboardingViews/splash_screen.dart';
import 'package:rjfruits/view/popularItemsView/popularItems_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());
      case RoutesName.onboarding1:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnBoardingScreen1());
      case RoutesName.onboarding2:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnBoardingScreen2());
      case RoutesName.onboarding3:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnBoardingScreen3());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.dashboard:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DashBoardScreen());
      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterView());
      case RoutesName.forget:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ForgetPasswordScreen(),
        );
      case RoutesName.bestSellers:
        return MaterialPageRoute(
          builder: (BuildContext context) => const BestSellers(),
        );
      case RoutesName.popularItems:
        return MaterialPageRoute(
          builder: (BuildContext context) => const PopularItems(),
        );
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
