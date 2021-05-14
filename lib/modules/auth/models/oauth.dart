import 'package:json_annotation/json_annotation.dart';

import 'oauth_type.dart';

part 'oauth.g.dart';

@JsonSerializable()
class OAuth {
  OAuthType oauthType;
  String connectionId;

  OAuth({
    required this.oauthType,
    required this.connectionId,
  });

  factory OAuth.fromJson(Map<String, dynamic> json) => _$OAuthFromJson(json);
  Map<String, dynamic> toJson() => _$OAuthToJson(this);
}
