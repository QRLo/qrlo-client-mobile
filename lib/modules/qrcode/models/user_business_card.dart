import 'package:json_annotation/json_annotation.dart';
import 'package:qrlo_mobile/modules/qrcode/models/abstract_qrcode_data.dart';

part 'user_business_card.g.dart';

@JsonSerializable()
class UserBusinessCard extends AbstractQRCodeData {
  int? id;
  int? userId;
  String company;
  String position;
  String phone;
  String email;
  bool? emailVerified;

  UserBusinessCard({
    this.id,
    this.userId,
    required this.company,
    required this.position,
    required this.phone,
    required this.email,
    this.emailVerified,
  });

  factory UserBusinessCard.fromJson(Map<String, dynamic> json) =>
      _$UserBusinessCardFromJson(json);
  Map<String, dynamic> toJson() => _$UserBusinessCardToJson(this);
}
