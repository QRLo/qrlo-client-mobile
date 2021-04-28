import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/config/routes_manager.dart';
import 'package:qrlo_mobile/modules/auth/routes/auth_entry_route.dart';
import 'package:qrlo_mobile/modules/auth/states/auth_state.dart';
import 'package:qrlo_mobile/modules/dashboard/routes/dashboard_route.dart';

class AuthLoadingPage extends StatelessWidget {
  const AuthLoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthState>(context, listen: false)
        .refreshToken()
        .then((_) => getIt<RoutesManager>().router.navigateTo(
              context,
              DashboardRoute().url,
              replace: true,
            ))
        .catchError((_) => getIt<RoutesManager>().router.navigateTo(
              context,
              AuthEntryRoute().url,
              replace: true,
            ));
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "QRLo",
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}