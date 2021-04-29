import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_domain.g.dart';

@JsonSerializable()
class AuthResponse {
  final String token;

  AuthResponse({@required this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
