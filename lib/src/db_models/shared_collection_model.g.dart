// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedCollectionModel _$SharedCollectionModelFromJson(
        Map<String, dynamic> json) =>
    SharedCollectionModel(
      user: ParseUserModel.fromJson(json['user'] as Map<String, dynamic>),
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      keywords: (json['keywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      numBookmarks: (json['numBookmarks'] as num?)?.toInt() ?? 0,
      objectId: json['objectId'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SharedCollectionModelToJson(
        SharedCollectionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'keywords': instance.keywords,
      'numBookmarks': instance.numBookmarks,
      'user': instance.user.toJson(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'objectId': instance.objectId,
    };
