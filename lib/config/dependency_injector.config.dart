// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../clients/backend_client.dart' as _i4;
import '../modules/qrcode/ui/qrcode_save_adapter.dart' as _i7;
import '../services/auth_service.dart' as _i3;
import '../services/business_card_service.dart' as _i5;
import '../services/profile_service.dart' as _i6;
import 'routes_manager.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthService>(() => _i3.AuthService());
  await gh.factoryAsync<_i4.BackendClient>(() => _i4.BackendClient.create(),
      preResolve: true);
  gh.factory<_i5.BusinessCardService>(() => _i5.BusinessCardService());
  gh.factory<_i6.ProfileService>(() => _i6.ProfileService());
  gh.factory<_i7.QRCodeSaveAdapter>(() => _i7.QRCodeSaveAdapter());
  gh.factory<_i8.RoutesManager>(() => _i8.RoutesManager());
  return get;
}
