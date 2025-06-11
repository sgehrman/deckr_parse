// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_collection_export_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkCollectionExportModel _$BookmarkCollectionExportModelFromJson(
        Map<String, dynamic> json) =>
    BookmarkCollectionExportModel(
      collection: BookmarkCollectionModel.fromJson(
          json['collection'] as Map<String, dynamic>),
      bookmarks: (json['bookmarks'] as List<dynamic>)
          .map((e) => IndexedBookmarkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookmarkCollectionExportModelToJson(
        BookmarkCollectionExportModel instance) =>
    <String, dynamic>{
      'collection': instance.collection.toJson(),
      'bookmarks': instance.bookmarks.map((e) => e.toJson()).toList(),
    };
