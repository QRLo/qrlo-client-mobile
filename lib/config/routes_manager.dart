import 'package:fluro/fluro.dart';
import 'package:injectable/injectable.dart';
import 'package:qrlo_mobile/modules/auth/routes/auth_entry_route.dart';
import 'package:qrlo_mobile/modules/dashboard/routes/dashboard_route.dart';
import 'package:qrlo_mobile/modules/qrcode/routes/qrcode_save_route.dart';

@injectable
class RoutesManager {
  static final _routes = [
    AuthEntryRoute(),
    DashboardRoute(),
    QRCodeSaveRoute(),
  ];
  FluroRouter _router = FluroRouter();

  RoutesManager() {
    RoutesManager._routes
        .forEach((route) => _router.define(route.url, handler: route.handler));
  }

  FluroRouter get router => _router;

  String get initialRoute => AuthEntryRoute().url;
}
