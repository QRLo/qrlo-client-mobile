// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessCard _$BusinessCardFromJson(Map<String, dynamic> json) {
  return BusinessCard(
    id: json['id'] as String?,
    company: json['company'] as String,
    position: json['position'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$BusinessCardToJson(BusinessCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'position': instance.position,
      'phone': instance.phone,
      'email': instance.email,
    };
