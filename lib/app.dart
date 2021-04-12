import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/config/routes_manager.dart';
import 'package:qrlo_mobile/modules/auth/states/auth_state.dart';
import 'package:qrlo_mobile/modules/welcome/ui/pages/welcome_page.dart';
import 'config/dependency_injector.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: getIt<RoutesManager>().initialRoute,
        theme: ThemeData(
          // primarySwatch: Colors.pink,
          backgroundColor: const Color(0xFFF89B6C),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFFF37221),
          accentColor: const Color(0xFFF33E21),
          canvasColor: const Color(0xFFF37221),
        ),
        onGenerateRoute: getIt<RoutesManager>().router.generator,
        home: WelcomePage(),
      ),
    );
  }
}
