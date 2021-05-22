import 'package:json_annotation/json_annotation.dart';
import 'package:qrlo_mobile/services/domains/missing_profile.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String email;
  String? firstName;
  String? lastName;
  bool verified;
  MissingProfile? missingProfile;
  int? version;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.verified,
    this.missingProfile,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
