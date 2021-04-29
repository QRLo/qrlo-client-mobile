// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'integrate_oauth_domain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntegrateOAuthRequest _$IntegrateOAuthRequestFromJson(
    Map<String, dynamic> json) {
  return IntegrateOAuthRequest(
    oAuthType: _$enumDecodeNullable(_$OAuthTypeEnumMap, json['oAuthType']),
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

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$OAuthTypeEnumMap = {
  OAuthType.KAKAO: 'KAKAO',
  OAuthType.NAVER: 'NAVER',
  OAuthType.GOOGLE: 'GOOGLE',
};
