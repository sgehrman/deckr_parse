import 'package:deckr_parse/src/db_models/parse_chat_conversation_model.dart';
import 'package:deckr_parse/src/parse_chat_message_utils.dart';
import 'package:deckr_parse/src/parse_live_query.dart';
import 'package:deckr_parse/src/parse_utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ConversationUtils {
  static const String className = 'ChatConversation';
  static const String membersField = 'members';
  static const String markedAsReadField = 'markedAsRead';

  static Future<bool> upload(ParseChatConversationModel model) async {
    final parseObject = ParseObject(className);

    parseObject.set(membersField, model.members);

    final response = await parseObject.save();
    if (response.success) {
      // print('$className created ${parseObject.objectId}');
    } else {
      print('Error while creating $className: ${response.error}');
    }

    return response.success;
  }

  static Future<bool> setMarkedAsRead({
    required ParseChatConversationModel model,
    required bool markedAsRead,
  }) async {
    final parseObject = await parseObjectForModel(model: model, fetch: false);

    parseObject.set(markedAsReadField, markedAsRead);

    final response = await parseObject.update();
    if (response.success) {
      // print('$className created ${parseObject.objectId}');
    } else {
      print('Error while creating $className: ${response.error}');
    }

    return response.success;
  }

  static QueryBuilder<ParseObject> _buildQuery({
    List<String> members = const [],
  }) {
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(className))
      ..orderByDescending('createdAt');

    if (members.isNotEmpty) {
      queryBuilder.whereArrayContainsAll(membersField, members);
    }

    return queryBuilder;
  }

  static ParseLiveQuery<ParseChatConversationModel> liveQuery({
    List<String> members = const [],
  }) {
    return ParseLiveQuery<ParseChatConversationModel>(
      query: _buildQuery(members: members),
      hasDescendingSort: true,
      disableUpdates: false,
      converter: (object) {
        return parseObjectToModel(object)!;
      },
    );
  }

  static Future<List<ParseChatConversationModel>> query({
    List<String> members = const [],
  }) async {
    final queryBuilder = _buildQuery(members: members);

    final result = <ParseChatConversationModel>[];

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      for (final o in response.results!) {
        final b = parseObjectToModel(o as ParseObject);

        if (b != null) {
          result.add(b);
        }
      }
    } else {
      print('Error while querying $className: ${response.error}');
    }

    return result;
  }

  static Future<bool> deleteWithMessages(
    ParseChatConversationModel model,
  ) async {
    var result = false;

    if (model.members.length == 2) {
      final query = await ParseChatMessageUtils.query(
        from: model.members.first,
        to: model.members[1],
      );

      for (final q in query) {
        result = await ParseChatMessageUtils.delete(q);

        // break out if one fails
        if (!result) {
          break;
        }
      }

      if (result) {
        // delete conversation
        result = await delete(model);
      }
    }

    return result;
  }

  static Future<bool> delete(ParseChatConversationModel model) async {
    final parseObject = await parseObjectForModel(model: model, fetch: false);

    final response = await parseObject.delete();

    return response.success;
  }

  static Future<ParseObject> parseObjectForModel({
    required ParseChatConversationModel model,
    required bool fetch,
  }) {
    return ParseUtils.parseObjectForId(
      className: className,
      objectId: model.objectId,
      fetch: fetch,
    );
  }

  static ParseChatConversationModel? parseObjectToModel(
    ParseObject parseObject,
  ) {
    final map = ParseUtils.parseObjectToJson(parseObject: parseObject);

    if (map.isNotEmpty) {
      return ParseChatConversationModel.fromJson(map);
    }

    return null;
  }
}
