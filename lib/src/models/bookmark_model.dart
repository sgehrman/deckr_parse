import 'package:deckr_parse/src/models/filterable.dart';
import 'package:dfc_dart/dfc_dart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookmark_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BookmarkModel extends Filterable {
  BookmarkModel({
    this.title = '',
    this.customTitle = '',
    this.description = '',
    String? url,
    this.favIconUrl = '',
    DateTime? dateAdded,
    DateTime? lastUsed,
    this.accessCount = 0,
  }) : dateAdded = dateAdded ?? DateTime.now(),
       lastUsed = lastUsed ?? DateTime.now(),
       // make sure all urls have removed the trailing slash.
       // we don't want the same url with and without with different icons/screenshots etc
       url = url?.removeTrailing('/') ?? '',
       super(title, second: url ?? '', third: description, forth: customTitle);

  factory BookmarkModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkModelFromJson(json);

  // key is based on the url, get it everytime to be save, cache it for speed
  String get key {
    return _key ??= Utls.keyFromString(url);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? _key;

  final String title;
  final String customTitle;
  final String description;
  final String url;
  final String favIconUrl; // could be a chrome-extension:// url
  final DateTime lastUsed;
  final DateTime dateAdded;
  final int accessCount;

  @override
  String toString() {
    return toJson().toString();
  }

  BookmarkModel copyWith({
    String? title,
    String? customTitle,
    String? description,
    String? url,
    String? favIconUrl,
    DateTime? lastUsed,
    DateTime? dateAdded,
    int? accessCount,
  }) {
    return BookmarkModel(
      title: title ?? this.title,
      customTitle: customTitle ?? this.customTitle,
      description: description ?? this.description,
      url: url ?? this.url,
      favIconUrl: favIconUrl ?? this.favIconUrl,
      lastUsed: lastUsed ?? this.lastUsed,
      dateAdded: dateAdded ?? this.dateAdded,
      accessCount: accessCount ?? this.accessCount,
    );
  }

  Map<String, dynamic> toJson() => _$BookmarkModelToJson(this);

  bool isValid() {
    return validURL(url);
  }

  // dates from chrome need to be converted from ints to strings
  // but it seems not all are ints?
  static Map<String, dynamic> convertDateForImport(Map<String, dynamic> map) {
    if (map['dateAdded'] is int) {
      final dateAdded =
          Utls.dateTimeFromEpochUs(map['dateAdded'] as int) ?? DateTime.now();

      // this string format is what JsonSerializer uses
      map['dateAdded'] = dateAdded.toIso8601String();
    } else if (map['lastVisitTime'] is double) {
      // HistoryItems have a lastVisitTime, use that if exists
      final dateAdded =
          Utls.dateTimeFromEpochUs((map['lastVisitTime'] as double).toInt()) ??
          DateTime.now();

      // this string format is what JsonSerializer uses
      map['dateAdded'] = dateAdded.toIso8601String();
    } else {
      // print('dataAdded is not an int? ${map['dateAdded']}');

      map['dateAdded'] = null;
    }

    return map;
  }

  // returns null if not the type of link we want
  static BookmarkModel? fromJsonFiltered(Map<String, dynamic> map) {
    final url = map['url'] as String?;

    if (validURL(url)) {
      return BookmarkModel.fromJson(map);
    }

    return null;
  }

  // returns null if not the type of link we want
  static BookmarkModel? fromChromeHistoryMap(Map<String, dynamic> map) {
    final url = map['url'] as String?;
    final title = map['title'] as String?;

    if (validURL(url)) {
      // we don't want the id or other fields
      return BookmarkModel.fromJson({'url': url, 'title': title});
    }

    return null;
  }

  // returns null if not the type of link we want
  static bool validURI(Uri uri) {
    if (UriUtils.isHttpUri(uri) || uri.isScheme('file')) {
      // no localhost
      if (!uri.host.contains('localhost')) {
        return true;
      }
    }

    // chrome://whats-new/, chrome://extensions etc
    if (uri.scheme == 'chrome') {
      // avoid chrome://newtab otherwise it shows up in recents
      if (!Utls.isNewTab(uri.toString())) {
        return true;
      }
    }

    return false;
  }

  static bool validURL(String? url) {
    if (url != null && url.isNotEmpty) {
      final uri = Uri.parse(url);

      return validURI(uri);
    }

    return false;
  }

  String get displayName {
    var result = customTitle;

    if (Utls.isEmpty(result)) {
      result = title;

      if (Utls.isEmpty(result)) {
        if (Utls.isNotEmpty(url)) {
          result = Uri.parse(url).host;
        }
      }
    }

    return result;
  }
}
