import 'package:deckr_parse/src/models/collection_rating_model.dart';
import 'package:deckr_parse/src/parse_utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CollectionRatingUtils {
  static const String className = 'CollectionRating';
  static const String userIdField = 'userId';
  static const String upField = 'up';
  static const String downField = 'down';
  static const String collectionIdField = 'collectionId';

  static Future<bool> upload(CollectionRatingModel model) async {
    final parseObject = ParseObject(className);

    var objectId = model.objectId;

    // should only be one, so look up rating if we don't have an objectId
    if (objectId.isEmpty) {
      final first = await queryFirst(
        userId: model.userId,
        collectionId: model.collectionId,
      );

      objectId = first.objectId;
    }

    // passed in existing model, use same objectId
    if (objectId.isNotEmpty) {
      parseObject.objectId = objectId;
    }

    parseObject.set(userIdField, model.userId);
    parseObject.set(upField, model.up);
    parseObject.set(downField, model.down);
    parseObject.set(collectionIdField, model.collectionId);

    final response = await parseObject.save();
    if (response.success) {
      // print('$className created ${parseObject.objectId}');
    } else {
      print('Error while creating $className: ${response.error}');
    }

    return response.success;
  }

  static QueryBuilder<ParseObject> _buildQuery({
    required String collectionId,
    String userId = '',
  }) {
    final queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(className))
          ..orderByDescending('createdAt')
          ..whereEqualTo('collectionId', collectionId);

    if (userId.isNotEmpty) {
      queryBuilder.whereEqualTo('userId', userId);
    }

    return queryBuilder;
  }

  static Future<List<CollectionRatingModel>> query({
    required String collectionId,
    String userId = '',
  }) async {
    final queryBuilder = _buildQuery(
      collectionId: collectionId,
      userId: userId,
    );

    final result = <CollectionRatingModel>[];

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      for (final o in response.results!) {
        final b = parseObjectToModel(o as ParseObject);

        if (b != null) {
          result.add(b);
        }
      }
    } else {
      ParseUtils.printParseError(
        response,
        contextInfo: 'Error while querying $className',
      );
    }

    return result;
  }

  static Future<CollectionRatingModel> queryFirst({
    required String collectionId,
    String userId = '',
  }) async {
    final ratings = await query(collectionId: collectionId, userId: userId);

    var result = CollectionRatingModel(
      userId: userId,
      collectionId: collectionId,
    );

    // should only be one
    if (ratings.isNotEmpty) {
      if (ratings.length == 1) {
        result = ratings.first;
      } else {
        print('Error: more than one rating');
      }
    }

    return result;
  }

  static Future<void> delete(ParseObject parseObject) async {
    await parseObject.delete();
  }

  static Future<ParseObject> parseObjectForModel(CollectionRatingModel model) {
    return ParseUtils.parseObjectForId(
      className: className,
      objectId: model.objectId,
    );
  }

  static CollectionRatingModel? parseObjectToModel(ParseObject parseObject) {
    final map = ParseUtils.parseObjectToJson(parseObject: parseObject);

    if (map.isNotEmpty) {
      return CollectionRatingModel.fromJson(map);
    }

    return null;
  }
}
