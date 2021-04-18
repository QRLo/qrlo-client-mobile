import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:qrlo_mobile/modules/auth/ui/pages/auth_loading_page.dart';
import 'package:qrlo_mobile/shared/base_route.dart';

class AuthLoadingRoute extends BaseRoute {
  @override
  Handler generateHandler() {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return AuthLoadingPage();
      },
    );
  }

  @override
  String get url => "/auth-loading";
}
