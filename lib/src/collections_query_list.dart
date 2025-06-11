import 'package:deckr_parse/src/db_models/shared_collection_model.dart';
import 'package:deckr_parse/src/paged_live_query.dart';
import 'package:flutter/material.dart';

class CollectionsQueryList extends StatefulWidget {
  const CollectionsQueryList({
    required this.itemBuilder,
    this.keyword = '',
    this.searchQuery = '',
    super.key,
  });

  final String keyword;
  final String searchQuery;
  final Widget Function(SharedCollectionModel model, int index) itemBuilder;

  @override
  State<CollectionsQueryList> createState() => _CollectionsQueryListState();
}

class _CollectionsQueryListState extends State<CollectionsQueryList> {
  final Map<int, List<SharedCollectionModel>> _queryPages = {};
  final List<PagedLiveQuery> _pagedQueries = [];
  int _page = 0;
  final _limit = 20;
  bool _hasMoreData = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _addQueryPage(_page);

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _disposePages();

    super.dispose();
  }

  void _scrollListener() {
    final nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

    if (_scrollController.position.pixels > nextPageTrigger) {
      if (_hasMoreData) {
        _page++;

        _addQueryPage(_page);
      }
    }
  }

  @override
  void didUpdateWidget(covariant CollectionsQueryList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.keyword != oldWidget.keyword ||
        widget.searchQuery != oldWidget.searchQuery) {
      _page = 0;
      _disposePages();
      _hasMoreData = true;

      _addQueryPage(_page);
    }
  }

  // need the pageNum param for the closure to work
  void _addQueryPage(int pageNum) {
    assert(_queryPages[pageNum] == null, '_queryPages[pageNum] not null');

    _queryPages[pageNum] = [];

    _pagedQueries.add(
      PagedLiveQuery(
        onChange: (list) {
          _queryPages[pageNum] = list;

          if (list.length < _limit) {
            _hasMoreData = false;
          }

          setState(() {});
        },
        keyword: widget.keyword,
        searchQuery: widget.searchQuery,
        limit: _limit,
        page: pageNum,
      ),
    );
  }

  void _disposePages() {
    for (final page in _pagedQueries) {
      page.dispose();
    }

    _pagedQueries.clear();
    _queryPages.clear();
  }

  @override
  Widget build(BuildContext context) {
    final items = <SharedCollectionModel>[];

    for (var i = 0; i < _queryPages.keys.length; i++) {
      items.addAll(_queryPages[i] ?? []);
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      controller: _scrollController,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final model = items[index];

        return widget.itemBuilder(model, index);
      },
    );
  }
}
