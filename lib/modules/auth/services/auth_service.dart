import 'package:injectable/injectable.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:qrlo_mobile/clients/backend_client.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/auth/models/auth.dart';

@injectable
class AuthService {
  Auth auth;
  bool isFetching = false;
  get backendClient => getIt<BackendClient>();

  Future<Auth> loginWithKakao() async {
    try {
      KakaoContext.clientId = "10b9cd95834895e8c746949f9883206f";
      String authCode = await isKakaoTalkInstalled()
          ? await AuthCodeClient.instance.requestWithTalk()
          : await AuthCodeClient.instance.request();
      // String authCode = await AuthCodeClient.instance.request();
      var response = await backendClient.conn.post(
        "auth/kakao",
        data: {
          "authCode": authCode,
          "redirectUri": "kakao${KakaoContext.clientId}://oauth",
        },
      );
      auth = Auth.fromJson(response.data);
      backendClient.accessToken = auth.jwt;
      return auth;
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

  Future<Auth> refreshToken() async {
    await Future.delayed(const Duration(seconds: 2));
    var response = await backendClient.conn.post("auth/refresh-token");
    auth = Auth.fromJson(response.data);
    backendClient.accessToken = auth.jwt;
    return auth;
  }
}
