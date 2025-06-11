import 'package:deckr_parse/src/db_models/parse_user_model.dart';
import 'package:deckr_parse/src/db_models/shared_collection_model.dart';
import 'package:dfc_dart/dfc_dart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookmark_collection_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BookmarkCollectionModel {
  BookmarkCollectionModel({
    required this.name,
    this.id = '', // hive id
    this.visible = true,
    this.collapsed = false,
    this.description = '',
    this.keywords = const [],

    // collection when shared, or downloaded
    this.sourceId = '',
    this.sourceDate,
  }) {
    // id should be unique in the current list
    // collisions should be near impossible, don't want to force the user to deal with the id
    // this allows the user to change the name, we use id to locate data, used as listId for getting bookmarks
    if (id.isEmpty) {
      id = Utls.uniqueFirestoreId();
    }
  }

  factory BookmarkCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkCollectionModelFromJson(json);

  String id;
  String name;
  bool visible;
  bool collapsed;
  String description;
  DateTime? sourceDate;
  String sourceId;
  List<String> keywords;

  @override
  String toString() {
    return toJson().toString();
  }

  SharedCollectionModel toSharedCollectionModel({
    required int numBookmarks,
    required ParseUserModel userModel,
  }) {
    return SharedCollectionModel(
      user: userModel,
      name: name,
      description: description,
      keywords: keywords,
      numBookmarks: numBookmarks,
    );
  }

  Map<String, dynamic> toJson() => _$BookmarkCollectionModelToJson(this);
}
