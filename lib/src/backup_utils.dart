import 'dart:convert';

import 'package:deckr_parse/src/models/bookmark_collection_backup_model.dart';
import 'package:deckr_parse/src/models/bookmark_collection_model.dart';
import 'package:deckr_parse/src/parse_user_provider.dart';
import 'package:deckr_parse/src/parse_utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class BackupUtils {
  static const String className = 'Backup';
  static const String jsonField = 'json';
  static const String ownerField = 'owner';

  static Future<bool> upload(BookmarkCollectionBackupModel backupModel) async {
    final user = ParseUserProvider().user;

    if (user != null) {
      final parseObject = ParseObject(className);

      final map = backupModel.toJson();

      parseObject.set(jsonField, json.encode(map));
      parseObject.set(ownerField, user.objectId ?? '');

      parseObject.setACL(user.getACL());

      final response = await parseObject.save();
      if (response.success) {
        print('Backup created ${parseObject.objectId}');
      } else {
        print('Error while creating Backup: ${response.error}');
      }

      return true;
    }

    return false;
  }

  static Future<void> delete(ParseObject backup) async {
    await backup.delete();
  }

  static Future<ParseObject> parseObjectForModel(
    BookmarkCollectionModel model,
  ) {
    return ParseUtils.parseObjectForId(
      className: className,
      objectId: model.id,
    );
  }

  static BookmarkCollectionBackupModel? parseObjectToModel(
    ParseObject parseObject,
  ) {
    final jsonString = parseObject.get<String>(jsonField) ?? '';

    if (jsonString.isNotEmpty) {
      final map = Map<String, dynamic>.from(
        json.decode(jsonString) as Map? ?? {},
      );

      return BookmarkCollectionBackupModel.fromJson(map);
    }

    return null;
  }

  static Future<List<ParseObject>> backupsForUser() async {
    final userId = ParseUserProvider().userId;

    if (userId.isNotEmpty) {
      final parseQuery = QueryBuilder<ParseObject>(ParseObject(className));

      parseQuery.whereEqualTo('owner', userId);
      final apiResponse = await parseQuery.query();

      if (apiResponse.success && apiResponse.results != null) {
        return apiResponse.results! as List<ParseObject>;
      } else {
        print('Error while querying backups: ${apiResponse.error}');
      }
    }

    return [];
  }

  static Future<BookmarkCollectionBackupModel?> load() async {
    final result = await backupsForUser();

    if (result.isNotEmpty) {
      return parseObjectToModel(result.first);
    }

    return null;
  }
}
