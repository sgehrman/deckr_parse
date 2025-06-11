import 'package:deckr_parse/src/db_models/parse_user_model.dart';
import 'package:deckr_parse/src/models/bookmark_collection_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shared_collection_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SharedCollectionModel {
  SharedCollectionModel({
    required this.user,
    required this.name,
    this.description = '',
    this.keywords = const [],
    this.numBookmarks = 0,
    this.objectId = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now(),
       createdAt = createdAt ?? DateTime.now();

  factory SharedCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$SharedCollectionModelFromJson(json);

  final String name;
  final String description;
  final List<String> keywords;
  final int numBookmarks;
  final ParseUserModel user;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String objectId;

  @override
  String toString() {
    return toJson().toString();
  }

  // called on download to convert the sharedCollection to a local collection
  // sourceId and sourceDate help link the local to the store
  BookmarkCollectionModel toBookmarkCollectionModel() {
    return BookmarkCollectionModel(
      name: name,
      description: description,
      keywords: keywords,
      sourceId: objectId,
      sourceDate: updatedAt,
    );
  }

  Map<String, dynamic> toJson() => _$SharedCollectionModelToJson(this);
}
