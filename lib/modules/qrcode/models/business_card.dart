import 'package:json_annotation/json_annotation.dart';
import 'package:qrlo_mobile/modules/qrcode/models/abstract_qrcode_data.dart';

part 'business_card.g.dart';

@JsonSerializable()
class BusinessCard extends AbstractQRCodeData {
  String? id;
  String company;
  String position;
  String phone;
  String email;

  BusinessCard({
    this.id,
    required this.company,
    required this.position,
    required this.phone,
    required this.email,
  });

  factory BusinessCard.fromJson(Map<String, dynamic> json) =>
      _$BusinessCardFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessCardToJson(this);
}
