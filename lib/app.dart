import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/config/routes_manager.dart';
import 'package:qrlo_mobile/modules/auth/states/auth_state.dart';
import 'package:qrlo_mobile/modules/auth/ui/pages/auth_entry_page.dart';
import 'config/dependency_injector.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthState(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: const Color(0xFFE57373),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFFE57373),
          accentColor: const Color(0xFFF33E21),
          canvasColor: const Color(0xFFE57373),
        ),
        onGenerateRoute: getIt<RoutesManager>().router.generator,
        home: AuthEntryPage(),
      ),
    );
  }
}
