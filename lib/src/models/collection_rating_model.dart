import 'package:json_annotation/json_annotation.dart';

part 'collection_rating_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class CollectionRatingModel {
  CollectionRatingModel({
    required this.userId,
    required this.collectionId,
    this.objectId = '',
    this.up = false,
    this.down = false,
  });

  factory CollectionRatingModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionRatingModelFromJson(json);

  final String objectId;
  final String userId;
  final String collectionId;
  bool up;
  bool down;

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => _$CollectionRatingModelToJson(this);
}
