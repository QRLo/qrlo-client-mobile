import 'package:json_annotation/json_annotation.dart';
import 'package:qrlo_mobile/modules/qrcode/models/abstract_qrcode_data.dart';

part 'business_card.g.dart';

@JsonSerializable(checked: true)
class BusinessCard extends AbstractQRCodeData {
  String imageUrl;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;

  BusinessCard({
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
  });

  factory BusinessCard.fromJson(Map<String, dynamic> json) =>
      _$BusinessCardFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessCardToJson(this);
}
