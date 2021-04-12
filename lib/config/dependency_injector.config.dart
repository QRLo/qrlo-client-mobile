// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../clients/auth/auth_client.dart';
import '../modules/auth/services/auth_service.dart';
import '../clients/backend_client.dart';
import '../modules/qrcode/ui/qrcode_save_adapter.dart';
import 'routes_manager.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<AuthClient>(() => AuthClient());
  gh.factory<AuthService>(() => AuthService());
  final resolvedBackendClient = await BackendClient.create();
  gh.factory<BackendClient>(() => resolvedBackendClient);
  gh.factory<QRCodeSaveAdapter>(() => QRCodeSaveAdapter());
  gh.factory<RoutesManager>(() => RoutesManager());
  return get;
}
