import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/config/routes_manager.dart';
import 'package:qrlo_mobile/modules/auth/routes/auth_entry_route.dart';
import 'package:qrlo_mobile/modules/auth/states/auth_state.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.lock_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text("Reset Password"),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.report,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text("Report"),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.power_settings_new,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text("Log Out"),
                  onTap: () {
                    context.read<AuthState>().logOut().then(
                        (value) => getIt<RoutesManager>().router.navigateTo(
                              context,
                              AuthEntryRoute().url,
                              replace: true,
                              transition: TransitionType.fadeIn,
                            ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
