import 'package:fluro/fluro.dart';

abstract class BaseRoute {
  late Handler _handler;
  BaseRoute() {
    _handler = generateHandler();
  }

  String get url;
  Handler get handler => _handler;

  Handler generateHandler();
}
