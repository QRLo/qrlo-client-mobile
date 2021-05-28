import 'package:json_annotation/json_annotation.dart';

part 'business_card_vcard_data.g.dart';

@JsonSerializable()
class BusinessCardVCardData {
  int id;
  int userId;

  BusinessCardVCardData(this.id, this.userId);

  factory BusinessCardVCardData.fromJson(Map<String, dynamic> json) =>
      _$BusinessCardVCardDataFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessCardVCardDataToJson(this);
}
