import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:rjfruits/repository/home_ui_repository.dart';
import 'package:rjfruits/utils/routes/routes.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view_model/auth_view_model.dart';
import 'package:rjfruits/view_model/cart_view_model.dart';
import 'package:rjfruits/view_model/home_view_model.dart';
import 'package:rjfruits/view_model/product_detail_view_model.dart';
import 'package:rjfruits/view_model/user_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeRepositoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeUiSwithchRepository(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductRepositoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartRepositoryProvider(),
        ),
      ],
      child: MaterialApp(
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
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
