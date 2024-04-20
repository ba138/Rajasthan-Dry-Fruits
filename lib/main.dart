import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rjfruits/utils/routes/routes.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        const MyApp(),
      );
    },
  );
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
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
