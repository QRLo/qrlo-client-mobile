import 'package:flutter/material.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/auth/models/user.dart';
import 'package:qrlo_mobile/modules/qrcode/models/user_business_card.dart';
import 'package:qrlo_mobile/services/profile_service.dart';

class ProfileState extends ChangeNotifier {
  ProfileService profileService = getIt<ProfileService>();
  User? basicProfile;
  List<UserBusinessCard> myBusinessCards = [];
  List<UserBusinessCard> contacts = [];

  Future<void> fetchAllProfiles() async {
    var responses = await Future.wait([
      profileService.fetchBasicProfile(),
      profileService.fetchBusinessCards()
    ]);
    basicProfile = responses[0] as User;
    myBusinessCards = responses[1] as List<UserBusinessCard>;

    notifyListeners();
  }

  Future<void> addBusinessCard({
    required name,
    required position,
    required email,
    required phone,
  }) async {
    try {
      final UserBusinessCard businessCard = UserBusinessCard(
        company: name,
        position: position,
        phone: phone,
        email: email,
      );
      final UserBusinessCard createdBusinessCard =
          await getIt<ProfileService>().addBusinessCard(businessCard);
      myBusinessCards.add(createdBusinessCard);
      // profile!.myBusinessCards.add(createdBusinessCard);
    } finally {
      notifyListeners();
    }
  }

  Future<void> addContact(int businessCardId) async {
    final UserBusinessCard addedBusinessCard =
        await profileService.addQrloContact(businessCardId);
    contacts.add(addedBusinessCard);
    notifyListeners();
  }
}
