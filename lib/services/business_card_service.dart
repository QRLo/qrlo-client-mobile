import 'package:injectable/injectable.dart';
import 'package:qrlo_mobile/clients/backend_client.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/qrcode/models/user_business_card.dart';

@injectable
class BusinessCardService {
  BackendClient get backendClient => getIt<BackendClient>();

  Future<UserBusinessCard> getBusinessCardForUserId(
      int businessCardId, int userId) async {
    var response = await backendClient.conn
        .get("users/$userId/businesscards/$businessCardId");

    return UserBusinessCard.fromJson(response.data);
  }
}
