import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:qrlo_mobile/clients/backend_client.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/main.dart';
import 'package:qrlo_mobile/modules/auth/services/domains/oauth_domain.dart';
import 'package:qrlo_mobile/modules/auth/models/oauth_type.dart';
import 'package:qrlo_mobile/modules/auth/services/domains/auth_domain.dart';
import 'package:qrlo_mobile/modules/auth/services/domains/integrate_oauth_domain.dart';

@injectable
class AuthService {
  static const String OAUTH_DATA_STORAGE_KEY = "oauth_data";
  get backendClient => getIt<BackendClient>();

  Future<void> loginWithKakao() async {
    KakaoContext.clientId = "10b9cd95834895e8c746949f9883206f";
    String authCode = await isKakaoTalkInstalled()
        ? await AuthCodeClient.instance.requestWithTalk()
        : await AuthCodeClient.instance.request();
    AccessTokenResponse token =
        await AuthApi.instance.issueAccessToken(authCode);
    final oAuth = new OAuthRequest(
      oAuthType: OAuthType.KAKAO,
      oAuthAccessToken: token.accessToken,
    );
    await _saveAuthToStorage(oAuth);
    await _doRequestQrloAuth(oAuth);
  }

  Future<void> requestQrloAuthFromStorage() async {
    final OAuthRequest? oAuth = await _fetchAuthFromStorage();
    if (oAuth == null) throw "Empty Auth Storage";
    await _doRequestQrloAuth(oAuth);
  }

  Future<void> _doRequestQrloAuth(OAuthRequest oAuth) async {
    var response = await backendClient.conn.post(
      "auth",
      data: oAuth,
    );
    backendClient.accessToken = AuthResponse.fromJson(response.data).token;
  }

  Future<void> integrateWithOAuth(String email) async {
    final OAuthRequest? oAuth = await _fetchAuthFromStorage();
    final IntegrateOAuthRequest integrateOAuthRequest =
        new IntegrateOAuthRequest(
      email: email,
      oAuthAccessToken: oAuth!.oAuthAccessToken,
      oAuthType: oAuth.oAuthType,
    );
    var response = await backendClient.conn.post(
      "auth/integrate",
      data: integrateOAuthRequest,
    );
    backendClient.accessToken = AuthResponse.fromJson(response.data).token;
  }

  Future<void> logOut() async {
    await storage.delete(key: OAUTH_DATA_STORAGE_KEY);
    backendClient.accessToken = "";
  }

  Future<OAuthRequest?> _fetchAuthFromStorage() async {
    final String? storedOAuth = await storage.read(key: OAUTH_DATA_STORAGE_KEY);
    if (storedOAuth?.isEmpty ?? true) return null;
    return OAuthRequest.fromJson(
        jsonDecode(utf8.fuse(base64).decode(storedOAuth!)));
  }

  Future<void> _saveAuthToStorage(OAuthRequest oAuth) async {
    final String base64AuthString =
        utf8.fuse(base64).encode(jsonEncode(oAuth.toJson()));
    await storage.write(key: OAUTH_DATA_STORAGE_KEY, value: base64AuthString);
  }
}
