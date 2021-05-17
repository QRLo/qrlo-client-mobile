import 'package:json_annotation/json_annotation.dart';
import 'package:qrlo_mobile/modules/auth/models/oauth.dart';
import 'package:qrlo_mobile/modules/qrcode/models/business_card.dart';
import 'package:qrlo_mobile/services/domains/missing_profile.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String email;
  String? firstName;
  String? lastName;
  List<BusinessCard> myBusinessCards;
  List<OAuth> oauths;
  bool verified;
  MissingProfile? missingProfile;
  int? version;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.myBusinessCards,
    required this.oauths,
    required this.verified,
    this.missingProfile,
    this.version,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
