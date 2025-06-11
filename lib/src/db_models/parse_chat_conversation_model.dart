import 'package:json_annotation/json_annotation.dart';

part 'parse_chat_conversation_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class ParseChatConversationModel {
  ParseChatConversationModel({
    required this.members,
    this.objectId = '',
    this.markedAsRead = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  factory ParseChatConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ParseChatConversationModelFromJson(json);

  final List<String> members;
  final bool markedAsRead;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String objectId;

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => _$ParseChatConversationModelToJson(this);
}
