import 'package:injectable/injectable.dart';
import 'package:qrlo_mobile/clients/backend_client.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';

@injectable
class ProfileService {
  get backendClient => getIt<BackendClient>();

  Future<void> fetchProfile() async {
    var response = await backendClient.conn.get("profile");
    print(response.data);
  }
}
