// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkModel _$BookmarkModelFromJson(Map<String, dynamic> json) =>
    BookmarkModel(
      title: json['title'] as String? ?? '',
      customTitle: json['customTitle'] as String? ?? '',
      description: json['description'] as String? ?? '',
      url: json['url'] as String?,
      favIconUrl: json['favIconUrl'] as String? ?? '',
      dateAdded: json['dateAdded'] == null
          ? null
          : DateTime.parse(json['dateAdded'] as String),
      lastUsed: json['lastUsed'] == null
          ? null
          : DateTime.parse(json['lastUsed'] as String),
      accessCount: (json['accessCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$BookmarkModelToJson(BookmarkModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'customTitle': instance.customTitle,
      'description': instance.description,
      'url': instance.url,
      'favIconUrl': instance.favIconUrl,
      'lastUsed': instance.lastUsed.toIso8601String(),
      'dateAdded': instance.dateAdded.toIso8601String(),
      'accessCount': instance.accessCount,
    };
