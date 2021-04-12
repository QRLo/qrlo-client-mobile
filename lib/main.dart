import 'package:flutter/material.dart';
import 'package:qrlo_mobile/app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'config/dependency_injector.dart';

final storage = new FlutterSecureStorage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(App());
}
