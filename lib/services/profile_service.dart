import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:qrlo_mobile/clients/backend_client.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/auth/models/user.dart';
import 'package:qrlo_mobile/modules/qrcode/models/user_business_card.dart';
import 'package:qrlo_mobile/services/domains/missing_profile.dart';

@injectable
class ProfileService {
  BackendClient get backendClient => getIt<BackendClient>();

  Future<User> fetchBasicProfile() async {
    var response = await backendClient.conn.get("profile");
    return User.fromJson(response.data);
  }

  Future<User> updateProfile(User user) async {
    var response = await backendClient.conn.put("profile", data: user.toJson());
    return User.fromJson(response.data);
  }

  Future<UserBusinessCard> addBusinessCard(
      UserBusinessCard businessCard) async {
    var response = await backendClient.conn
        .post("profile/mybusinesscards", data: businessCard.toJson());
    return UserBusinessCard.fromJson(response.data);
  }

  Future<Uint8List> getQrCodeImageForBusinessCard(
      UserBusinessCard businessCard) async {
    var response = await getIt<BackendClient>().conn.get<ResponseBody>(
        "profile/mybusinesscards/${businessCard.id}/generate-qr",
        options: Options(responseType: ResponseType.stream));
    return Uint8List.fromList((await response.data!.stream.toList())
        .expand((element) => element)
        .toList());
  }

  Future<List<UserBusinessCard>> fetchBusinessCards() async {
    var response = await backendClient.conn.get("profile/mybusinesscards");

    return (response.data as List)
        .map((e) => UserBusinessCard.fromJson(e))
        .toList();
  }

  Future<UserBusinessCard> addQrloContact(int businessCardId) async {
    var response = await backendClient.conn.post("profile/contacts", data: {
      "id": businessCardId,
    });
    return UserBusinessCard.fromJson(response.data);
  }
}
