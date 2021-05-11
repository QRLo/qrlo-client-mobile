import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/config/routes_manager.dart';
import 'package:qrlo_mobile/modules/auth/states/auth_state.dart';
import 'package:qrlo_mobile/modules/auth/ui/views/auth_loading_view.dart';
import 'package:qrlo_mobile/modules/auth/ui/views/profile_creation_modal_view.dart';
import 'package:qrlo_mobile/modules/auth/ui/views/registration_modal_view.dart';
import 'package:qrlo_mobile/modules/dashboard/routes/dashboard_route.dart';

class AuthEntryPage extends StatefulWidget {
  @override
  _AuthEntryPageState createState() => _AuthEntryPageState();
}

class _AuthEntryPageState extends State<AuthEntryPage> {
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthState>();
    if (authState.currentState == AuthStateEnum.NEED_LOGIN) {
      authState.refreshToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthState>();
    switch (authState.currentState) {
      case AuthStateEnum.AUTHENTICATED:
        authState.fetchProfile();
        break;
      case AuthStateEnum.AUTHORIZED:
        Future.microtask(() {
          getIt<RoutesManager>()
              .router
              .navigateTo(context, DashboardRoute().url, replace: true);
        });
        break;
      case AuthStateEnum.REGISTRAION_REQUIRED:
        Future.microtask(() {
          showModalBottomSheet<String>(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.white,
              builder: (BuildContext context) => RegistrationModalView(
                    key: Key("RegistrationModalView"),
                  ));
        });
        break;
      case AuthStateEnum.PROFILE_CREATION_REQUIRED:
        Future.microtask(() {
          showModalBottomSheet<String>(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.white,
              builder: (BuildContext context) => ProfileCreationModalView(
                  missingProfile: authState.profile!.missingProfile!));
        });
        break;
      default:
        break;
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
                  child: Consumer<AuthState>(
                    builder: (context, authState, widget) {
                      if (authState.currentState == AuthStateEnum.FETCHING) {
                        return AuthLoadingView();
                      }
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              onPressed:
                                  context.read<AuthState>().loginWithKakao,
                              child: Image.asset(
                                  "assets/images/kakao_login_wide.png"),
                            ),
                            TextButton(
                              onPressed: () => {
                                // TODO: NAVER OAUTH SHOULD BE IMPLEMENTED
                              },
                              child: Image.asset(
                                  "assets/images/naver_login_wide.png"),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
            ),
          );
        },
      ),
    );
  }
}
