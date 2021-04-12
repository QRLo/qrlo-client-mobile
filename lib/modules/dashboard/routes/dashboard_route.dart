import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:qrlo_mobile/modules/dashboard/ui/pages/dashboard_entry_page.dart';
import 'package:qrlo_mobile/shared/base_route.dart';

class DashboardRoute extends BaseRoute {
  @override
  Handler generateHandler() {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return DashboardEntryPage();
      },
    );
  }

  @override
  String get url => "/dashboard";
}
