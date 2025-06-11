// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkCollectionModel _$BookmarkCollectionModelFromJson(
        Map<String, dynamic> json) =>
    BookmarkCollectionModel(
      name: json['name'] as String,
      id: json['id'] as String? ?? '',
      visible: json['visible'] as bool? ?? true,
      collapsed: json['collapsed'] as bool? ?? false,
      description: json['description'] as String? ?? '',
      keywords: (json['keywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sourceId: json['sourceId'] as String? ?? '',
      sourceDate: json['sourceDate'] == null
          ? null
          : DateTime.parse(json['sourceDate'] as String),
    );

Map<String, dynamic> _$BookmarkCollectionModelToJson(
        BookmarkCollectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'visible': instance.visible,
      'collapsed': instance.collapsed,
      'description': instance.description,
      'sourceDate': instance.sourceDate?.toIso8601String(),
      'sourceId': instance.sourceId,
      'keywords': instance.keywords,
    };
