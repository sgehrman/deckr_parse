// ==================================================

import 'dart:async';

import 'package:deckr_parse/src/collections/collection_keywords.dart';
import 'package:deckr_parse/src/collections/collection_utils.dart';
import 'package:flutter/material.dart';

class CollectionCounts {
  factory CollectionCounts() {
    return _instance ??= CollectionCounts._();
  }

  CollectionCounts._();

  static CollectionCounts? _instance;
  Completer<Map<String, int>>? _completer;
  Map<String, int> _cache = {};

  int count(String keyword) {
    return _cache[keyword] ?? 0;
  }

  Future<void> _countFuture(Map<String, int> map, String id) async {
    final count = await CollectionUtils.collectionCount(keyword: id);

    map[id] = count;
  }

  // setState after this returns to refresh with counts
  Future<Map<String, int>> initialize(BuildContext context) async {
    if (_completer == null) {
      _completer = Completer<Map<String, int>>();

      final map = <String, int>{};

      final futures = <Future<void>>[];
      for (final item in CollectionKeywords.keywords(context)) {
        futures.add(_countFuture(map, item.id));
      }

      // this is faster
      await Future.wait(futures);

      _cache = map;
      _completer!.complete(map);
    }

    return _completer!.future;
  }
}
