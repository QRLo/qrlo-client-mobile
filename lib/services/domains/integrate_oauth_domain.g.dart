// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'integrate_oauth_domain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntegrateOAuthRequest _$IntegrateOAuthRequestFromJson(
    Map<String, dynamic> json) {
  return IntegrateOAuthRequest(
    oAuthType: _$enumDecode(_$OAuthTypeEnumMap, json['oAuthType']),
    oAuthAccessToken: json['oAuthAccessToken'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$IntegrateOAuthRequestToJson(
        IntegrateOAuthRequest instance) =>
    <String, dynamic>{
      'oAuthType': _$OAuthTypeEnumMap[instance.oAuthType],
      'oAuthAccessToken': instance.oAuthAccessToken,
      'email': instance.email,
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

VerifyOTPRequest _$VerifyOTPRequestFromJson(Map<String, dynamic> json) {
  return VerifyOTPRequest(
    oAuthType: _$enumDecode(_$OAuthTypeEnumMap, json['oAuthType']),
    oAuthAccessToken: json['oAuthAccessToken'] as String,
    otp: json['otp'] as String,
  );
}

Map<String, dynamic> _$VerifyOTPRequestToJson(VerifyOTPRequest instance) =>
    <String, dynamic>{
      'oAuthType': _$OAuthTypeEnumMap[instance.oAuthType],
      'oAuthAccessToken': instance.oAuthAccessToken,
      'otp': instance.otp,
    };
