import 'package:injectable/injectable.dart';
import 'package:qrlo_mobile/clients/backend_client.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/auth/models/user.dart';
import 'package:qrlo_mobile/modules/qrcode/models/business_card.dart';

@injectable
class ProfileService {
  BackendClient get backendClient => getIt<BackendClient>();

  Future<User> fetchProfile() async {
    var response = await backendClient.conn.get("profile");
    return User.fromJson(response.data);
  }

  Future<User> updateProfile(User user) async {
    var response = await backendClient.conn.put("profile", data: user.toJson());
    return User.fromJson(response.data);
  }

  Future<BusinessCard> addBusinessCard(BusinessCard businessCard) async {
    var response = await backendClient.conn
        .post("profile/mybusinesscards", data: businessCard.toJson());
    return BusinessCard.fromJson(response.data);
  }
}
