import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/config/routes_manager.dart';
import 'package:qrlo_mobile/modules/auth/states/auth_state.dart';
import 'package:qrlo_mobile/modules/auth/ui/views/auth_loading_view.dart';
import 'package:qrlo_mobile/modules/auth/ui/views/auth_selection_view.dart';
import 'package:qrlo_mobile/modules/dashboard/routes/dashboard_route.dart';

class AuthEntryPage extends StatelessWidget {
  const AuthEntryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthState>();
    if (authState.isAuthenticated) {
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
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 35.0, vertical: 100.0),
                child: authState.isFetching
                    ? AuthLoadingView()
                    : AuthSelectionView(),
              ),
            ),
          );
        },
      ),
    );
  }
}
