import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/config/routes_manager.dart';
import 'package:qrlo_mobile/modules/auth/states/auth_state.dart';
import 'package:qrlo_mobile/modules/auth/ui/views/auth_loading_view.dart';
import 'package:qrlo_mobile/modules/auth/ui/views/auth_selection_view.dart';
import 'package:qrlo_mobile/modules/auth/ui/views/registration_modal_view.dart';
import 'package:qrlo_mobile/modules/dashboard/routes/dashboard_route.dart';

class AuthEntryPage extends StatefulWidget {
  const AuthEntryPage({Key key}) : super(key: key);

  @override
  _AuthEntryPageState createState() => _AuthEntryPageState();
}

class _AuthEntryPageState extends State<AuthEntryPage> {
  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthState>();
    if (authState.currentState == AuthStateEnum.AUTHENTICATED) {
      Timer.run(() {
        getIt<RoutesManager>().router.navigateTo(
              context,
              DashboardRoute().url,
              transition: TransitionType.fadeIn,
              replace: true,
            );
      });
    }
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (authState.currentState == AuthStateEnum.REGISTRAION_REQUIRED) {
            Timer.run(() => _showRegistrationModal(context, constraints));
          }
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 35.0, vertical: 100.0),
                child: authState.currentState == AuthStateEnum.FETCHING
                    ? AuthLoadingView()
                    : AuthSelectionView(),
              ),
            ),
          );
        },
      ),
    );
  }

  _showRegistrationModal(BuildContext context, BoxConstraints constraints) {
    return showModalBottomSheet<String>(
      context: context,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      builder: (BuildContext context) => RegistrationModalView(
        constraints: constraints,
      ),
    ).then((thing) => print(thing));
  }
}
