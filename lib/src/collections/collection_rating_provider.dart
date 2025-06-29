import 'dart:async';

import 'package:deckr_parse/deckr_parse.dart';
import 'package:flutter/material.dart';

class CollectionRatingProvider extends ChangeNotifier {
  CollectionRatingProvider({required this.collectionModel}) {
    _calcLikes();
  }

  final SharedCollectionModel collectionModel;

  CollectionRatingModel? _ratingModel;
  ThumbValues _thumbValues = ThumbValues.zero;

  // getters
  CollectionRatingModel? get ratingModel => _ratingModel;
  ThumbValues get thumbValues => _thumbValues;

  Future<void> _calcLikes() async {
    _ratingModel = await CollectionRatingCache.instance.ratingModel(
      collectionModel,
    );

    _thumbValues = await CollectionRatingCache.instance.thumbValues(
      collectionModel,
    );

    // calculate likes might be slow, hasListeners returns false
    // if we have alraedy been disposed()
    if (hasListeners) {
      notifyListeners();
    }
  }

  Future<void> updateThumbValue({
    required bool? prevValue,
    required bool? value,
  }) async {
    _ratingModel =
        _ratingModel ??
        CollectionRatingModel(
          userId: ParseUserProvider().userId,
          collectionId: collectionModel.objectId,
        );

    _ratingModel!.down = value == false;
    _ratingModel!.up = value ?? false;

    // sync cache, it doesn't refresh automatically
    // we only update our our changes
    _syncCache(prevValue: prevValue, newValue: value);

    notifyListeners();

    await CollectionRatingUtils.upload(_ratingModel!);
  }

  // sync our cache so we don't have to refetch
  void _syncCache({required bool? prevValue, required bool? newValue}) {
    var newUp = _thumbValues.upCount;
    var newDown = _thumbValues.downCount;

    if (newValue == false) {
      newDown++;

      // prev value was true, then subtract upCount
      if (prevValue ?? false) {
        newUp--;
      }
    } else if (newValue ?? false) {
      newUp++;

      // prev value was false, then subtract upCount
      if (prevValue == false) {
        newDown--;
      }
    } else {
      // prev value was true, then subtract upCount
      if (prevValue ?? false) {
        newUp--;
      } else if (prevValue == false) {
        newDown--;
      }
    }

    _thumbValues = ThumbValues(upCount: newUp, downCount: newDown);

    CollectionRatingCache.instance.updateValuesForModel(
      collectionModel,
      _thumbValues,
    );
  }
}
