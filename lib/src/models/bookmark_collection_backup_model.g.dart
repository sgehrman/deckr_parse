// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_collection_backup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkCollectionBackupModel _$BookmarkCollectionBackupModelFromJson(
        Map<String, dynamic> json) =>
    BookmarkCollectionBackupModel(
      collections: (json['collections'] as List<dynamic>)
          .map((e) =>
              BookmarkCollectionExportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String? ?? '',
      timestamp: (json['timestamp'] as num?)?.toInt() ?? 0,
      version: (json['version'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$BookmarkCollectionBackupModelToJson(
        BookmarkCollectionBackupModel instance) =>
    <String, dynamic>{
      'collections': instance.collections.map((e) => e.toJson()).toList(),
      'version': instance.version,
      'id': instance.id,
      'timestamp': instance.timestamp,
    };
