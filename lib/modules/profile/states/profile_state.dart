import 'package:flutter/material.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/auth/models/user.dart';
import 'package:qrlo_mobile/modules/qrcode/models/user_business_card.dart';
import 'package:qrlo_mobile/services/contact_service.dart';
import 'package:qrlo_mobile/services/profile_service.dart';

class ProfileState extends ChangeNotifier {
  ProfileService profileService = getIt<ProfileService>();
  ContactService contactService = getIt<ContactService>();
  User? basicProfile;
  List<UserBusinessCard> businessCards = [];
  List<UserBusinessCard> contacts = [];

  Future<void> fetchAllProfiles() async {
    var responses = await Future.wait([
      profileService.fetchBasicProfile(),
      profileService.fetchBusinessCards(),
      contactService.fetchQrloContacts(),
    ]);
    basicProfile = responses[0] as User;
    businessCards = responses[1] as List<UserBusinessCard>;
    contacts = responses[2] as List<UserBusinessCard>;

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
      businessCards.add(createdBusinessCard);
      // profile!.businessCards.add(createdBusinessCard);
    } finally {
      notifyListeners();
    }
  }

  Future<void> addContact(int businessCardId) async {
    UserBusinessCard contact =
        await contactService.addQrloContact(businessCardId);
    contacts.add(contact);
    notifyListeners();
  }
}
