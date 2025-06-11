// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parse_chat_conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParseChatConversationModel _$ParseChatConversationModelFromJson(
        Map<String, dynamic> json) =>
    ParseChatConversationModel(
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      objectId: json['objectId'] as String? ?? '',
      markedAsRead: json['markedAsRead'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ParseChatConversationModelToJson(
        ParseChatConversationModel instance) =>
    <String, dynamic>{
      'members': instance.members,
      'markedAsRead': instance.markedAsRead,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'objectId': instance.objectId,
    };
