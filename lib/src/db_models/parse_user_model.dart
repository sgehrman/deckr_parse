import 'package:json_annotation/json_annotation.dart';

part 'parse_user_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class ParseUserModel {
  ParseUserModel({
    this.objectId = '',
    this.avatar = '',
    this.emailVerified = false,
    this.username = '',
    this.email = '',
    this.licenseKey = '',
    this.blueCheck = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  factory ParseUserModel.fromJson(Map<String, dynamic> json) =>
      _$ParseUserModelFromJson(json);

  final DateTime createdAt;
  final DateTime updatedAt;
  final String avatar;
  final String objectId;
  final String username;
  final String email;
  final String licenseKey;
  final bool emailVerified;
  final bool blueCheck;

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => _$ParseUserModelToJson(this);
}
