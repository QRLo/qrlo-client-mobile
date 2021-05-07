import 'package:json_annotation/json_annotation.dart';
import 'package:qrlo_mobile/modules/qrcode/models/abstract_qrcode_data.dart';

part 'business_card.g.dart';

@JsonSerializable()
class BusinessCard extends AbstractQRCodeData {
  @JsonKey(required: true)
  String firstName;
  @JsonKey(required: true)
  String lastName;
  @JsonKey(required: true)
  String company;
  @JsonKey(required: true)
  String phone;
  @JsonKey(required: true)
  String email;

  BusinessCard({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.phone,
    required this.email,
  });

  factory BusinessCard.fromJson(Map<String, dynamic> json) =>
      _$BusinessCardFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessCardToJson(this);
}
