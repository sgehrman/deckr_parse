import 'package:deckr_parse/src/models/bookmark_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'indexed_bookmark_model.g.dart';

// this model is sent to the frontend for display

@JsonSerializable(explicitToJson: true)
class IndexedBookmarkModel {
  IndexedBookmarkModel({required this.index, required this.bookmark});

  factory IndexedBookmarkModel.fromJson(Map<String, dynamic> json) =>
      _$IndexedBookmarkModelFromJson(json);

  int index;
  final BookmarkModel bookmark;

  @override
  String toString() {
    return toJson().toString();
  }

  // returns null if not the type of link we want
  static IndexedBookmarkModel? fromJsonFiltered(Map<String, dynamic> map) {
    final url = map['url'] as String?;

    if (BookmarkModel.validURL(url)) {
      return IndexedBookmarkModel.fromJson(map);
    }

    return null;
  }

  Map<String, dynamic> toJson() => _$IndexedBookmarkModelToJson(this);
}
