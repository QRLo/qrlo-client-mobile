// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessCard _$BusinessCardFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'firstName',
    'lastName',
    'company',
    'phone',
    'email'
  ]);
  return BusinessCard(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    company: json['company'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$BusinessCardToJson(BusinessCard instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'company': instance.company,
      'phone': instance.phone,
      'email': instance.email,
    };
