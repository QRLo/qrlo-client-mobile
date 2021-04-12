import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:qrlo_mobile/modules/welcome/ui/pages/welcome_page.dart';
import 'package:qrlo_mobile/shared/base_route.dart';

class WelcomeRoute extends BaseRoute {
  @override
  Handler generateHandler() {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return WelcomePage();
      },
    );
  }

  @override
  String get url => "/welcome";
}
