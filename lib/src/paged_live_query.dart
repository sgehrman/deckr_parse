import 'dart:async';

import 'package:deckr_parse/src/collections/collection_utils.dart';
import 'package:deckr_parse/src/db_models/shared_collection_model.dart';
import 'package:deckr_parse/src/parse_live_query.dart';

class PagedLiveQuery {
  PagedLiveQuery({
    required this.onChange,
    required this.keyword,
    required this.searchQuery,
    required this.page,
    required this.limit,
  }) {
    _updateQuery();
  }

  final void Function(List<SharedCollectionModel>) onChange;
  final String keyword;
  final String searchQuery;
  final int page;
  final int limit;

  ParseLiveQuery<SharedCollectionModel>? _query;
  StreamSubscription<List<SharedCollectionModel>>? _subscription;

  void dispose() {
    _unsubscribe();
    _query?.dispose();
  }

  void _updateQuery() {
    _query?.dispose();

    _query = CollectionUtils.liveQuery(
      keyword: keyword,
      searchQuery: searchQuery,
      page: page,
      limit: limit,
    );

    if (_subscription != null) {
      _unsubscribe();
    }

    _subscribe(_query!.stream());
  }

  void _subscribe(Stream<List<SharedCollectionModel>> stream) {
    _subscription = stream.listen(
      (data) {
        onChange(data);
      },
      onError: (Object error, StackTrace stackTrace) {
        // do something with the error
        print('PagedLiveQuery _subscribe() error: $error');
        print(stackTrace);
      },
      onDone: () {
        // do we care?
      },
    );
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
  }
}
