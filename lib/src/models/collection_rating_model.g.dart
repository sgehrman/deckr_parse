// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionRatingModel _$CollectionRatingModelFromJson(
        Map<String, dynamic> json) =>
    CollectionRatingModel(
      userId: json['userId'] as String,
      collectionId: json['collectionId'] as String,
      objectId: json['objectId'] as String? ?? '',
      up: json['up'] as bool? ?? false,
      down: json['down'] as bool? ?? false,
    );

Map<String, dynamic> _$CollectionRatingModelToJson(
        CollectionRatingModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'userId': instance.userId,
      'collectionId': instance.collectionId,
      'up': instance.up,
      'down': instance.down,
    };
