import 'package:json_annotation/json_annotation.dart';

part 'parse_chat_message_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class ParseChatMessageModel {
  ParseChatMessageModel({
    required this.to,
    required this.from,
    required this.members,
    this.text = '',
    this.objectId = '',
    this.image = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  factory ParseChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ParseChatMessageModelFromJson(json);

  final String to;
  final String from;
  final List<String> members;
  final String text;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String image;
  final String objectId;

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => _$ParseChatMessageModelToJson(this);
}
