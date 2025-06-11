import 'package:deckr_parse/src/models/bookmark_collection_export_model.dart';
import 'package:dfc_flutter/dfc_flutter_web.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookmark_collection_backup_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BookmarkCollectionBackupModel {
  BookmarkCollectionBackupModel({
    required this.collections,
    this.id = '',
    this.timestamp = 0,
    this.version = 1,
  }) {
    if (id.isEmpty) {
      id = Utils.uniqueFirestoreId();
    }

    if (timestamp == 0) {
      timestamp = DateTime.now().millisecondsSinceEpoch;
    }
  }

  factory BookmarkCollectionBackupModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkCollectionBackupModelFromJson(json);

  List<BookmarkCollectionExportModel> collections;
  int version;
  String id;
  int timestamp;

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => _$BookmarkCollectionBackupModelToJson(this);
}
