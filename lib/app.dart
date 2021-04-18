import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/config/routes_manager.dart';
import 'package:qrlo_mobile/modules/auth/states/auth_state.dart';
import 'package:qrlo_mobile/modules/auth/ui/pages/auth_loading_page.dart';
import 'package:qrlo_mobile/modules/dashboard/ui/pages/dashboard_entry_page.dart';
import 'config/dependency_injector.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: const Color(0xFFF89B6C),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFF37221),
        accentColor: const Color(0xFFF33E21),
        canvasColor: const Color(0xFFF37221),
      ),
      onGenerateRoute: getIt<RoutesManager>().router.generator,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthState(),
          ),
        ],
        child: Consumer<AuthState>(
          builder: (_, authState, __) {
            return authState.isAuthenticated
                ? DashboardEntryPage()
                : AuthLoadingPage();
          },
        ),
      ),
    );
  }
}
