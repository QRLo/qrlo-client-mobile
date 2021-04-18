import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:qrlo_mobile/modules/auth/ui/pages/auth_entry_page.dart';
import 'package:qrlo_mobile/shared/base_route.dart';

class AuthEntryRoute extends BaseRoute {
  @override
  String get url => "/auth";
  @override
  Handler generateHandler() {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return AuthEntryPage();
      },
    );
  }
}
