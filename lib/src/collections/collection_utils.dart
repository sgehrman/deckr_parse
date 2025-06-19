import 'dart:convert';

import 'package:deckr_parse/src/collections/bookmark_image_uploader.dart';
import 'package:deckr_parse/src/db_models/shared_collection_model.dart';
import 'package:deckr_parse/src/models/indexed_bookmark_model.dart';
import 'package:deckr_parse/src/parse_live_query.dart';
import 'package:deckr_parse/src/parse_user_provider.dart';
import 'package:deckr_parse/src/parse_utils.dart';
import 'package:dfc_flutter/dfc_flutter_web.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CollectionUtils {
  static const String kClassName = 'Collection';
  static const String kBookmarkListPointerField = 'bookmarks';
  static const String kUserPointerField = 'user';
  static const String kBookmarkListClassName = 'BookmarkList';
  static const String kJsonArrayField = 'bookmarks';
  static const String kImagesField = 'images';
  static const String kNameField = 'name';
  static const String kDescriptionField = 'description';

  static const kLatestCollectionId = 'latest';
  static const kMySharesCollectionId = 'my-shares';

  static bool isSearchableKeyword(String keyword) {
    return keyword != kLatestCollectionId && keyword != kMySharesCollectionId;
  }

  static Future<Map<String, dynamic>> uploadCollection({
    required SharedCollectionModel collection,
    required List<IndexedBookmarkModel> bookmarks,
    required Uri? Function(IndexedBookmarkModel) imageUri,
  }) async {
    final bookmarkMaps = bookmarks.map((e) => json.encode(e)).toList();

    final bookmarksObject = ParseObject(kBookmarkListClassName);
    bookmarksObject.set(kJsonArrayField, bookmarkMaps);

    // save images in the bookmarksObject
    final images = await BookmarkImageUploader.uploadBookmarkImages(
      bookmarks: bookmarks,
      imageUri: imageUri,
    );

    bookmarksObject.set(kImagesField, images);

    final listResponse = await bookmarksObject.save();
    if (listResponse.success) {
      final parseObject = ParseObject(kClassName);

      final collectionMap = collection.toJson();

      final validKeys = ['name', 'description', 'keywords', 'numBookmarks'];
      for (final entry in collectionMap.entries) {
        if (validKeys.contains(entry.key)) {
          parseObject.set(entry.key, entry.value);
        }
      }

      parseObject.set(kBookmarkListPointerField, bookmarksObject);
      parseObject.set(kUserPointerField, ParseUserProvider().user);

      final response = await parseObject.save();

      if (response.success) {
        // print('Collection created ${parseObject.objectId}');
        // print(response.results);

        if (Utils.isNotEmpty(response.results)) {
          // should only be one result
          final pobj = response.results!.first as ParseObject;

          return pobj.toJson();
        }
      } else {
        print('Error while creating Collection: ${response.success}');
      }
    } else {
      print('Error while creating bookmarkList: ${listResponse.success}');
    }

    return {};
  }

  static Future<void> deleteCollection(ParseObject collection) async {
    // get objectId for bookmarks list
    final bookmarksPointer = collection.get<ParseObject>(
      kBookmarkListPointerField,
    );
    if (bookmarksPointer != null) {
      final objectId = bookmarksPointer.objectId;

      if (objectId != null) {
        final bookmarkList = ParseObject(kBookmarkListClassName)
          ..objectId = objectId;

        await bookmarkList.delete();

        // only delete the collection if bookmarkList was successful
        await collection.delete();
      }
    }
  }

  static Future<BookmarksAndImages> bookmarksForCollection(
    ParseObject collection,
  ) async {
    final results = <IndexedBookmarkModel>[];
    Map<String, ParseFileBase>? images;

    final bookmarksPointer = collection.get<ParseObject>(
      kBookmarkListPointerField,
    );
    if (bookmarksPointer != null) {
      final objectId = bookmarksPointer.objectId;

      if (objectId != null) {
        final response = await bookmarksPointer.getObject(objectId);

        if (response.success) {
          final bookmarkList = response.result as ParseObject?;

          if (bookmarkList != null) {
            final jsonArray = List<String>.from(
              bookmarkList.get(kJsonArrayField) as List? ?? [],
            );

            for (final jsonStr in jsonArray) {
              final bookmarkMap = Map<String, dynamic>.from(
                json.decode(jsonStr) as Map? ?? {},
              );

              results.add(IndexedBookmarkModel.fromJson(bookmarkMap));
            }

            // get the images
            images = bookmarkList.get<Map<String, ParseFileBase>>(kImagesField);
          }
        }
      }
    } else {
      print("FAILED: getBookmarks - collection.get<ParseObject>('bookmarks')");
    }

    return BookmarksAndImages(bookmarks: results, images: images ?? {});
  }

  static Future<ParseObject> parseObjectForModel(SharedCollectionModel model) {
    return ParseUtils.parseObjectForId(
      className: kClassName,
      objectId: model.objectId,
    );
  }

  static QueryBuilder<ParseObject> _buildSearchQuery({
    required String searchText,
  }) {
    // ---------------------------
    // search on bookmarks list
    final bookmarkListQuery = QueryBuilder<ParseObject>(
      ParseObject(kClassName),
    );

    final pointerQuery = QueryBuilder<ParseObject>(
      ParseObject(kBookmarkListClassName),
    );
    pointerQuery.whereContains(kJsonArrayField, searchText);

    bookmarkListQuery.whereMatchesQuery(
      kBookmarkListPointerField,
      pointerQuery,
    );

    // ---------------------------
    // search on description
    final descriptionQuery = QueryBuilder<ParseObject>(ParseObject(kClassName));
    descriptionQuery.whereContains(kDescriptionField, searchText);

    // ---------------------------
    // search on name
    final nameQuery = QueryBuilder<ParseObject>(ParseObject(kClassName));
    nameQuery.whereContains(kNameField, searchText);

    return QueryBuilder.or(ParseObject(kClassName), [
      bookmarkListQuery,
      nameQuery,
      descriptionQuery,
    ]);
  }

  static QueryBuilder<ParseObject> _buildQuery({
    required String keyword,
    required String searchText,
    required int page,
    required int limit,
  }) {
    var resultBuilder = QueryBuilder<ParseObject>(ParseObject(kClassName));

    if (searchText.length > 2) {
      resultBuilder = _buildSearchQuery(searchText: searchText);
    } else if (keyword == kMySharesCollectionId) {
      final user = ParseUserProvider().user;
      if (user != null) {
        resultBuilder.whereEqualTo(kUserPointerField, user);
      }
    } else if (keyword.isNotEmpty && isSearchableKeyword(keyword)) {
      resultBuilder.whereArrayContainsAll('keywords', [keyword]);
    }

    resultBuilder.orderByDescending('createdAt');
    resultBuilder.setLimit(limit);

    if (page > 0) {
      resultBuilder.setAmountToSkip(page * limit);
    }

    // this fetches the user record
    resultBuilder.includeObject([kUserPointerField]);

    return resultBuilder;
  }

  static ParseLiveQuery<SharedCollectionModel> liveQuery({
    required String keyword,
    required String searchQuery,
    required int page,
    required int limit,
  }) {
    return ParseLiveQuery<SharedCollectionModel>(
      query: _buildQuery(
        keyword: keyword,
        searchText: searchQuery,
        page: page,
        limit: limit,
      ),
      disableUpdates: page > 0,
      hasDescendingSort: true,
      converter: (object) {
        return parseObjectToModel(object)!;
      },
    );
  }

  static Future<List<SharedCollectionModel>> query({
    required String keyword,
    required String searchQuery,
    required int page,
    required int limit,
  }) async {
    final queryBuilder = _buildQuery(
      keyword: keyword,
      searchText: searchQuery,
      page: page,
      limit: limit,
    );

    final result = <SharedCollectionModel>[];

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      for (final o in response.results!) {
        final b = parseObjectToModel(o as ParseObject);

        if (b != null) {
          result.add(b);
        }
      }
    }

    return result;
  }

  static Future<SharedCollectionModel?> objectWithId(String objectId) async {
    try {
      final query = ParseObject(kClassName);
      final response = await query.getObject(objectId);

      if (response.success && response.result != null) {
        return parseObjectToModel(response.result as ParseObject);
      } else {
        print('objectWithId: Object not found.');
      }
    } catch (e) {
      print('Error objectWithId: $e');
    }

    return null;
  }

  static SharedCollectionModel? parseObjectToModel(ParseObject parseObject) {
    // full: true gets the user which we included in the query
    final map = ParseUtils.parseObjectToJson(
      parseObject: parseObject,
      full: true,
    );

    // the avatar file need to be converted from a file map to just the url
    final userMap = map['user'] as Map? ?? {};
    final file = userMap['avatar'] as Map? ?? {};
    userMap['avatar'] = file['url'] as String? ?? '';

    // it needs a cast to Map<String, dynamic> or it fails fromJson
    map['user'] = Map<String, dynamic>.from(userMap);

    if (map.isNotEmpty) {
      return SharedCollectionModel.fromJson(map);
    }

    return null;
  }

  static Future<int> collectionCount({required String keyword}) async {
    if (keyword.isNotEmpty && isSearchableKeyword(keyword)) {
      final resultBuilder = QueryBuilder<ParseObject>(ParseObject(kClassName));

      resultBuilder.whereArrayContainsAll('keywords', [keyword]);
      final response = await resultBuilder.count();

      if (response.success) {
        return response.count;
      } else {
        print('${response.error}');
      }
    }

    return 0;
  }
}

// =====================================================

class BookmarksAndImages {
  BookmarksAndImages({required this.bookmarks, required this.images});
  final List<IndexedBookmarkModel> bookmarks;
  final Map<String, ParseFileBase> images;

  String imageUrlForBookmark(IndexedBookmarkModel bookmark) {
    final parseFile = images[bookmark.bookmark.key];
    if (parseFile != null) {
      return parseFile.url ?? '';
    }

    return '';
  }
}
