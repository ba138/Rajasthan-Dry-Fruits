import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/utils/routes/routes.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view_model/auth_view_model.dart';
import 'package:rjfruits/view_model/user_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => AuthViewModel(),
            ),
            ChangeNotifierProvider(
              create: (_) => UserViewModel(),
            ),
          ],
          child: const MyApp(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
