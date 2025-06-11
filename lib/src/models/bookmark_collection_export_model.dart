import 'package:deckr_parse/src/models/bookmark_collection_model.dart';
import 'package:deckr_parse/src/models/indexed_bookmark_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookmark_collection_export_model.g.dart';

// BookmarkCollectionModel doesn't contain the bookmarks, just the collection info
// this is used to write a colllection to a file, or backup to firebase since it contains all the data

@JsonSerializable(explicitToJson: true)
class BookmarkCollectionExportModel {
  BookmarkCollectionExportModel({
    required this.collection,
    required this.bookmarks,
  });

  factory BookmarkCollectionExportModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkCollectionExportModelFromJson(json);

  final BookmarkCollectionModel collection;
  final List<IndexedBookmarkModel> bookmarks;

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => _$BookmarkCollectionExportModelToJson(this);
}
