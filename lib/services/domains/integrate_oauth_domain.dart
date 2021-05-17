import 'package:json_annotation/json_annotation.dart';
import 'package:qrlo_mobile/modules/auth/models/oauth_type.dart';

import 'oauth_domain.dart';

part 'integrate_oauth_domain.g.dart';

@JsonSerializable()
class IntegrateOAuthRequest extends OAuthRequest {
  final String email;

  IntegrateOAuthRequest({
    required OAuthType oAuthType,
    required String oAuthAccessToken,
    required this.email,
  }) : super(
          oAuthAccessToken: oAuthAccessToken,
          oAuthType: oAuthType,
        );
  factory IntegrateOAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$IntegrateOAuthRequestFromJson(json);
  Map<String, dynamic> toJson() => _$IntegrateOAuthRequestToJson(this);
}

@JsonSerializable()
class VerifyOTPRequest extends OAuthRequest {
  final String otp;

  VerifyOTPRequest({
    required OAuthType oAuthType,
    required String oAuthAccessToken,
    required this.otp,
  }) : super(
          oAuthAccessToken: oAuthAccessToken,
          oAuthType: oAuthType,
        );
  factory VerifyOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOTPRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyOTPRequestToJson(this);
}
