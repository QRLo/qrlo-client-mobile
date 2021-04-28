import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/auth/services/auth_service.dart';

@preResolve
@injectable
class BackendClient {
  static const BASE_URL = "http://192.168.2.10:3000/api/v1/";
  // static const BASE_URL = "http://localhost:3000/api/v1/";
  Dio _dio;
  String _accessToken;

  BackendClient() {
    BaseOptions baseOptions = new BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );
    _dio = new Dio(baseOptions);
    _dio.interceptors.addAll([
      LogInterceptor(
        requestHeader: true,
        responseBody: true,
      ),
      InterceptorsWrapper(onRequest: (RequestOptions options) {
        if (_accessToken != null) {
          options.headers["Authorization"] = "Bearer " + _accessToken;
        }
        return options;
      }, onError: (DioError e) async {
        if (e.response?.statusCode == 401 &&
            e.request?.path != null &&
            !e.request.path.startsWith('auth')) {
          await getIt<AuthService>().requestQrloAuthFromStorage();

          RequestOptions request = e.response.request;
          request.headers["Authorization"] = _accessToken;
          return this._dio.request(
                request.path,
                data: request.data,
                options: request,
              );
        }
        return e;
      }),
    ]);
  }

  @factoryMethod
  static Future<BackendClient> create() async {
    final instance = BackendClient();
    await instance.conn.get('health');
    Timer.periodic(new Duration(seconds: 30), (_) async {
      await getIt<BackendClient>().conn.get('health');
    });
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var cookieJar = PersistCookieJar(
      dir: appDocDir.path + "/.cookies/",
    );
    return instance..conn.interceptors.addAll([CookieManager(cookieJar)]);
  }

  Dio get conn => _dio;
  set accessToken(String accessToken) => _accessToken = accessToken;
}

class AuthRequiredException implements Exception {}
