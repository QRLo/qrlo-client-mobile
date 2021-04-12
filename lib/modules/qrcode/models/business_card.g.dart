// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessCard _$BusinessCardFromJson(Map<String, dynamic> json) {
  return $checkedNew('BusinessCard', json, () {
    final val = BusinessCard(
      imageUrl: $checkedConvert(json, 'imageUrl', (v) => v as String),
      firstName: $checkedConvert(json, 'firstName', (v) => v as String),
      lastName: $checkedConvert(json, 'lastName', (v) => v as String),
      phoneNumber: $checkedConvert(json, 'phoneNumber', (v) => v as String),
      email: $checkedConvert(json, 'email', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$BusinessCardToJson(BusinessCard instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
    };
