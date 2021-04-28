import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qrlo_mobile/modules/auth/models/oauth_type.dart';

part 'auth_domain.g.dart';

@JsonSerializable()
class OAuth {
  final OAuthType oAuthType;
  final String oAuthAccessToken;

  OAuth({@required this.oAuthType, @required this.oAuthAccessToken});

  factory OAuth.fromJson(Map<String, dynamic> json) => _$OAuthFromJson(json);
  Map<String, dynamic> toJson() => _$OAuthToJson(this);
}

@JsonSerializable()
class AuthResponse {
  final String token;

  AuthResponse({@required this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
