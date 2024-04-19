import 'package:flutter/material.dart';
import 'package:rjfruits/view/onboardingViews/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffffffff),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // Set app bar color to white
          elevation: 0, // Remove app bar elevation
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
