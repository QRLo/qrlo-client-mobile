import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:qrlo_mobile/clients/backend_client.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/main.dart';
import 'package:qrlo_mobile/modules/auth/models/auth.dart';
import 'package:qrlo_mobile/modules/auth/models/oauth_type.dart';
import 'package:qrlo_mobile/modules/auth/services/domains/auth_domain.dart';

@injectable
class AuthService {
  static const String OAUTH_DATA_STORAGE_KEY = "oauth_data";

  Auth auth;
  get backendClient => getIt<BackendClient>();

  Future<void> loginWithKakao() async {
    try {
      KakaoContext.clientId = "10b9cd95834895e8c746949f9883206f";
      String authCode = await isKakaoTalkInstalled()
          ? await AuthCodeClient.instance.requestWithTalk()
          : await AuthCodeClient.instance.request();
      AccessTokenResponse token =
          await AuthApi.instance.issueAccessToken(authCode);
      final oAuth = new OAuth(
        oAuthType: OAuthType.KAKAO,
        oAuthAccessToken: token.accessToken,
      );
      await _saveAuthToStorage(oAuth);
      await _doRequestQrloAuth(oAuth);
    } on KakaoAuthException catch (e) {
      print(e);
      throw e;
    } on KakaoClientException catch (e) {
      print(e);
      throw e;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> requestQrloAuthFromStorage() async {
    final OAuth oAuth = await _fetchAuthFromStorage();
    await _doRequestQrloAuth(oAuth);
  }

  Future<void> _doRequestQrloAuth(OAuth oAuth) async {
    var response = await backendClient.conn.post(
      "auth",
      data: oAuth,
    );
    backendClient.accessToken = AuthResponse.fromJson(response.data).token;
  }

  Future<void> logOut() async {
    await storage.delete(key: OAUTH_DATA_STORAGE_KEY);
    backendClient.accessToken = null;
  }

  Future<OAuth> _fetchAuthFromStorage() async {
    final String storedOAuth = await storage.read(key: OAUTH_DATA_STORAGE_KEY);
    if (storedOAuth?.isEmpty ?? true) return null;
    return OAuth.fromJson(jsonDecode(utf8.fuse(base64).decode(storedOAuth)));
  }

  Future<void> _saveAuthToStorage(OAuth oAuth) async {
    final String base64AuthString =
        utf8.fuse(base64).encode(jsonEncode(oAuth.toJson()));
    await storage.write(key: OAUTH_DATA_STORAGE_KEY, value: base64AuthString);
  }
}
