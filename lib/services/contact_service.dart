import 'package:injectable/injectable.dart';
import 'package:qrlo_mobile/clients/backend_client.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/qrcode/models/user_business_card.dart';

@injectable
class ContactService {
  BackendClient get backendClient => getIt<BackendClient>();

  Future<UserBusinessCard> addQrloContact(int businessCardId) async {
    var response = await backendClient.conn.post("profile/contacts", data: {
      "id": businessCardId,
    });
    return UserBusinessCard.fromJson(response.data);
  }
}
