import 'package:deckr_parse/src/collections/collection_rating_utils.dart';
import 'package:deckr_parse/src/db_models/shared_collection_model.dart';
import 'package:deckr_parse/src/models/collection_rating_model.dart';
import 'package:deckr_parse/src/parse_user_provider.dart';

class ThumbValues {
  const ThumbValues({required this.upCount, required this.downCount});

  static const ThumbValues zero = ThumbValues(upCount: 0, downCount: 0);

  final int upCount;
  final int downCount;
}

// =====================================================

class CollectionRatingCache {
  CollectionRatingCache._();
  static CollectionRatingCache instance = CollectionRatingCache._();

  final Map<String, ThumbValues> _cache = {};
  final Map<String, CollectionRatingModel> _ratingModelCache = {};

  Future<CollectionRatingModel> ratingModel(SharedCollectionModel model) async {
    final userId = ParseUserProvider().userId;
    final key = '${model.objectId}:$userId';
    var result = _ratingModelCache[key];

    if (result == null) {
      result = await CollectionRatingUtils.queryFirst(
        collectionId: model.objectId,
        userId: userId,
      );

      _ratingModelCache[key] = result;
    }

    return result;
  }

  Future<ThumbValues> thumbValues(SharedCollectionModel model) async {
    final cached = _cache[model.objectId];
    if (cached != null) {
      return cached;
    }

    // set this while we async get the values
    // don't want to run twice
    _cache[model.objectId] = ThumbValues.zero;

    final values = await _thumbValues(bookmarkCollection: model);

    _cache[model.objectId] = values;

    return values;
  }

  void updateValuesForModel(SharedCollectionModel model, ThumbValues values) {
    _cache[model.objectId] = values;
  }

  static Future<ThumbValues> _thumbValues({
    required SharedCollectionModel bookmarkCollection,
  }) async {
    try {
      var thumbsUp = 0;
      var thumbsDown = 0;

      final ratingsForCollection = await CollectionRatingUtils.query(
        collectionId: bookmarkCollection.objectId,
      );

      for (final rating in ratingsForCollection) {
        if (rating.down) {
          thumbsDown++;
        }
        if (rating.up) {
          thumbsUp++;
        }
      }

      return ThumbValues(upCount: thumbsUp, downCount: thumbsDown);
    } catch (err) {
      print(err);
    }

    return ThumbValues.zero;
  }
}
