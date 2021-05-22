import 'package:json_annotation/json_annotation.dart';

import 'oauth_type.dart';

part 'oauth.g.dart';

@JsonSerializable()
class OAuth {
  int? id;
  OAuthType oauthType;
  String connectionId;

  OAuth({
    this.id,
    required this.oauthType,
    required this.connectionId,
  });

  factory OAuth.fromJson(Map<String, dynamic> json) => _$OAuthFromJson(json);
  Map<String, dynamic> toJson() => _$OAuthToJson(this);
}
