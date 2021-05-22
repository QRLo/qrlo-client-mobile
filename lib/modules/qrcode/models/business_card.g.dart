// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessCard _$BusinessCardFromJson(Map<String, dynamic> json) {
  return BusinessCard(
    id: json['id'] as int?,
    userId: json['userId'] as int?,
    company: json['company'] as String,
    position: json['position'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    emailVerified: json['emailVerified'] as bool?,
  );
}

Map<String, dynamic> _$BusinessCardToJson(BusinessCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'company': instance.company,
      'position': instance.position,
      'phone': instance.phone,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
    };
