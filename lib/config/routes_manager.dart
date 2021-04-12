import 'package:fluro/fluro.dart';
import 'package:qrlo_mobile/modules/auth/routes/auth_route.dart';
import 'package:injectable/injectable.dart';
import 'package:qrlo_mobile/modules/dashboard/routes/dashboard_route.dart';
import 'package:qrlo_mobile/modules/qrcode/routes/qrcode_save_route.dart';

@injectable
class RoutesManager {
  static final _routes = [
    AuthRoute(),
    DashboardRoute(),
    QRCodeSaveRoute(),
  ];
  FluroRouter _router;

  RoutesManager() {
    this._router = FluroRouter();
    RoutesManager._routes
        .forEach((route) => _router.define(route.url, handler: route.handler));
  }

  FluroRouter get router => _router;

  String get initialRoute => AuthRoute().url;
}
