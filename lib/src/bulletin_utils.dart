import 'package:deckr_parse/src/db_models/bulletin_model.dart';
import 'package:deckr_parse/src/parse_live_query.dart';
import 'package:deckr_parse/src/parse_utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class BulletinUtils {
  static const String className = 'Bulletin';
  static const String messageField = 'message';
  static const String titleField = 'title';

  static Future<bool> upload(BulletinModel model) async {
    final parseObject = ParseObject(className);

    parseObject.set(titleField, model.title);
    parseObject.set(messageField, model.message);

    final response = await parseObject.save();
    if (response.success) {
      // print('$className created ${parseObject.objectId}');
    } else {
      ParseUtils.printParseError(
        response,
        contextInfo: 'Error while creating $className',
      );
    }

    return response.success;
  }

  static ParseLiveQuery<BulletinModel> liveQuery() {
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(className))
      ..orderByDescending('createdAt');

    return ParseLiveQuery<BulletinModel>(
      query: queryBuilder,
      hasDescendingSort: true,
      disableUpdates: false,
      converter: (object) {
        return parseObjectToModel(object)!;
      },
    );
  }

  static Future<void> delete(ParseObject parseObject) async {
    await parseObject.delete();
  }

  static Future<ParseObject> parseObjectForModel(BulletinModel model) {
    return ParseUtils.parseObjectForId(
      className: className,
      objectId: model.objectId,
    );
  }

  static BulletinModel? parseObjectToModel(ParseObject parseObject) {
    final map = ParseUtils.parseObjectToJson(parseObject: parseObject);

    if (map.isNotEmpty) {
      return BulletinModel.fromJson(map);
    }

    return null;
  }
}
