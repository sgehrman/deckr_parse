// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulletin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulletinModel _$BulletinModelFromJson(Map<String, dynamic> json) =>
    BulletinModel(
      title: json['title'] as String,
      message: json['message'] as String,
      objectId: json['objectId'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BulletinModelToJson(BulletinModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'title': instance.title,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'message': instance.message,
    };
