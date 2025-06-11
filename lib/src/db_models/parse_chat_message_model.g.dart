// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parse_chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParseChatMessageModel _$ParseChatMessageModelFromJson(
        Map<String, dynamic> json) =>
    ParseChatMessageModel(
      to: json['to'] as String,
      from: json['from'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      text: json['text'] as String? ?? '',
      objectId: json['objectId'] as String? ?? '',
      image: json['image'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ParseChatMessageModelToJson(
        ParseChatMessageModel instance) =>
    <String, dynamic>{
      'to': instance.to,
      'from': instance.from,
      'members': instance.members,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'image': instance.image,
      'objectId': instance.objectId,
    };
