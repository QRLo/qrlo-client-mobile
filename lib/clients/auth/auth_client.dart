import 'package:injectable/injectable.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:qrlo_mobile/clients/backend_client.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/auth/models/auth.dart';

@injectable
class AuthClient {
  final backendClient = getIt<BackendClient>();

  Future<Auth> loginWithKakao(String authCode) async {
    var response = await backendClient.conn.post(
      "auth/kakao",
      data: {
        "authCode": authCode,
        "redirectUri": "kakao${KakaoContext.clientId}://oauth",
      },
    );
    var data = Auth.fromJson(response.data);
    backendClient.conn.options.headers["Authorization"] = "Bearer ${data.jwt}";
    return data;
  }
}
