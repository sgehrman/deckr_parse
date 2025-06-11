import 'package:json_annotation/json_annotation.dart';

part 'bulletin_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class BulletinModel {
  BulletinModel({
    required this.title,
    required this.message,
    this.objectId = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  factory BulletinModel.fromJson(Map<String, dynamic> json) =>
      _$BulletinModelFromJson(json);

  final String objectId;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String message;

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => _$BulletinModelToJson(this);
}
