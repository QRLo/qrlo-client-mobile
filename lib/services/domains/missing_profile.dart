import 'package:json_annotation/json_annotation.dart';

part 'missing_profile.g.dart';

@JsonSerializable()
class MissingProfile {
  final List<String> fields;

  MissingProfile({required this.fields});

  factory MissingProfile.fromJson(Map<String, dynamic> json) =>
      _$MissingProfileFromJson(json);
  Map<String, dynamic> toJson() => _$MissingProfileToJson(this);
}
