// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_domain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuthRequest _$OAuthRequestFromJson(Map<String, dynamic> json) {
  return OAuthRequest(
    oAuthType: _$enumDecode(_$OAuthTypeEnumMap, json['oAuthType']),
    oAuthAccessToken: json['oAuthAccessToken'] as String,
  );
}

Map<String, dynamic> _$OAuthRequestToJson(OAuthRequest instance) =>
    <String, dynamic>{
      'oAuthType': _$OAuthTypeEnumMap[instance.oAuthType],
      'oAuthAccessToken': instance.oAuthAccessToken,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$OAuthTypeEnumMap = {
  OAuthType.KAKAO: 'KAKAO',
  OAuthType.NAVER: 'NAVER',
  OAuthType.GOOGLE: 'GOOGLE',
};
