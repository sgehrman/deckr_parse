// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parse_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParseUserModel _$ParseUserModelFromJson(Map<String, dynamic> json) =>
    ParseUserModel(
      objectId: json['objectId'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      emailVerified: json['emailVerified'] as bool? ?? false,
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      licenseKey: json['licenseKey'] as String? ?? '',
      blueCheck: json['blueCheck'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ParseUserModelToJson(ParseUserModel instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'avatar': instance.avatar,
      'objectId': instance.objectId,
      'username': instance.username,
      'email': instance.email,
      'licenseKey': instance.licenseKey,
      'emailVerified': instance.emailVerified,
      'blueCheck': instance.blueCheck,
    };
