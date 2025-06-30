import 'dart:async';

import 'package:deckr_parse/src/parse_utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ParseLiveQuery<T> {
  ParseLiveQuery({
    required this.query,
    required this.converter,
    // set to true if descending order on list
    // this is how new items are appended or inserted
    required this.hasDescendingSort,

    // disable if page!=0
    required this.disableUpdates,
  }) {
    _setup();
  }

  void dispose() {
    _cancelQuery();
    _streamController.close();
  }

  final List<ParseObject> _objects = [];
  final StreamController<List<ParseObject>> _streamController =
      StreamController();
  final LiveQuery _liveQuery = LiveQuery(debug: false);
  Subscription<ParseObject>? _subscription;
  final QueryBuilder<ParseObject> query;
  final T Function(ParseObject) converter;
  final bool hasDescendingSort;
  final bool disableUpdates;

  Stream<List<T>> stream() {
    T convert(ParseObject element) {
      return converter(element)!;
    }

    return _streamController.stream.map((e) {
      return e.map(convert).toList();
    });
  }

  // ================================================================
  // private methods

  Future<void> _setup() async {
    // initial load
    await _loadQuery();

    if (!disableUpdates) {
      await _subscribeToUpdates();
    }
  }

  Future<void> _subscribeToUpdates() async {
    _subscription = await _liveQuery.client.subscribe<ParseObject>(query);

    _subscription!.on(LiveQueryEvent.create, (value) {
      // print('*** CREATE ***: $value ');

      // new items created added to end if ascending order
      if (!hasDescendingSort) {
        _objects.add(value as ParseObject);
      } else {
        _objects.insert(0, value as ParseObject);
      }

      _streamController.add(_objects);
    });

    _subscription!.on(LiveQueryEvent.update, (ParseObject value) {
      // print('*** UPDATE ***: $value ');

      final idx = _objects.indexWhere(
        (element) => element.objectId == value.objectId,
      );

      _objects[idx] = value;
      _streamController.add(_objects);
    });

    _subscription!.on(LiveQueryEvent.delete, (ParseObject value) {
      // print('*** DELETE ***: $value ');

      _objects.removeWhere((element) => element.objectId == value.objectId);
      _streamController.add(_objects);
    });
  }

  Future<void> _loadQuery() async {
    final apiResponse = await query.query();

    var parseObjects = <ParseObject>[];

    if (apiResponse.success && apiResponse.results != null) {
      parseObjects = apiResponse.results! as List<ParseObject>;
    } else {
      ParseUtils.printParseError(
        apiResponse,
        contextInfo: 'Error while querying ParseLiveQuery',
      );
    }

    _objects.clear();
    _objects.addAll(parseObjects);

    _streamController.add(_objects);
  }

  void _cancelQuery() {
    if (_subscription != null) {
      _liveQuery.client.unSubscribe<ParseObject>(_subscription!);

      _subscription = null;
    }
  }
}
