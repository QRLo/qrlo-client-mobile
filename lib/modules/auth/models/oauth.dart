import 'package:json_annotation/json_annotation.dart';

import 'oauth_type.dart';

part 'oauth.g.dart';

@JsonSerializable()
class OAuth {
  final OAuthType oAuthType;
  final String oAuthAccessToken;

  OAuth({required this.oAuthType, required this.oAuthAccessToken});

  factory OAuth.fromJson(Map<String, dynamic> json) => _$OAuthFromJson(json);
  Map<String, dynamic> toJson() => _$OAuthToJson(this);
}
