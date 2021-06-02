import 'package:injectable/injectable.dart';
import 'package:qrlo_mobile/clients/backend_client.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/qrcode/models/user_business_card.dart';

@injectable
class BusinessCardService {
  BackendClient get backendClient => getIt<BackendClient>();

  Future<UserBusinessCard> getBusinessCardById(int id) async {
    var response = await backendClient.conn.get("businesscards/$id");
    return UserBusinessCard.fromJson(response.data);
  }
}
