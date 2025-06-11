// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indexed_bookmark_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexedBookmarkModel _$IndexedBookmarkModelFromJson(
        Map<String, dynamic> json) =>
    IndexedBookmarkModel(
      index: (json['index'] as num).toInt(),
      bookmark:
          BookmarkModel.fromJson(json['bookmark'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IndexedBookmarkModelToJson(
        IndexedBookmarkModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'bookmark': instance.bookmark.toJson(),
    };
