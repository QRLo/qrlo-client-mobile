// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    email: json['email'] as String,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    myBusinessCards: (json['myBusinessCards'] as List<dynamic>)
        .map((e) => BusinessCard.fromJson(e as Map<String, dynamic>))
        .toList(),
    oauths: (json['oauths'] as List<dynamic>)
        .map((e) => OAuth.fromJson(e as Map<String, dynamic>))
        .toList(),
    missingProfile: json['missingProfile'] == null
        ? null
        : MissingProfile.fromJson(
            json['missingProfile'] as Map<String, dynamic>),
    version: json['version'] as int?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'myBusinessCards': instance.myBusinessCards,
      'oauths': instance.oauths,
      'missingProfile': instance.missingProfile,
      'version': instance.version,
    };
