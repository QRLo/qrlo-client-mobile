import 'package:json_annotation/json_annotation.dart';
import 'package:qrlo_mobile/modules/auth/models/oauth_type.dart';

part 'oauth_domain.g.dart';

@JsonSerializable()
class OAuthRequest {
  final OAuthType oAuthType;
  final String oAuthAccessToken;

  OAuthRequest({required this.oAuthType, required this.oAuthAccessToken});

  factory OAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$OAuthRequestFromJson(json);
  Map<String, dynamic> toJson() => _$OAuthRequestToJson(this);
}
