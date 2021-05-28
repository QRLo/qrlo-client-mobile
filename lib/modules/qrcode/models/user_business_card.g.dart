// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_business_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBusinessCard _$UserBusinessCardFromJson(Map<String, dynamic> json) {
  return UserBusinessCard(
    id: json['id'] as int?,
    userId: json['userId'] as int?,
    company: json['company'] as String,
    position: json['position'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    emailVerified: json['emailVerified'] as bool?,
  );
}

Map<String, dynamic> _$UserBusinessCardToJson(UserBusinessCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'company': instance.company,
      'position': instance.position,
      'phone': instance.phone,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
    };
