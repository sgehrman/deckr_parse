import 'package:deckr_parse/src/conversation_utils.dart';
import 'package:deckr_parse/src/db_models/parse_chat_conversation_model.dart';
import 'package:deckr_parse/src/db_models/parse_chat_message_model.dart';
import 'package:deckr_parse/src/parse_live_query.dart';
import 'package:deckr_parse/src/parse_utils.dart';
import 'package:dfc_flutter/dfc_flutter_web.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ParseChatMessageUtils {
  static const String className = 'ChatMessage';
  static const String textField = 'text';
  static const String toField = 'to';
  static const String fromField = 'from';
  static const String membersField = 'members';
  static const String imageField = 'image';

  static Future<bool> uploadChatMessage({
    required ParseChatMessageModel model,
    ParseFileBase? parseFile,
  }) async {
    final parseObject = ParseObject(className);

    if (parseFile != null) {
      // image file is deleted when this message is delete automaticlally by cloud code we added to back4app
      parseObject.set(imageField, parseFile);
    }

    parseObject.set(textField, model.text);
    parseObject.set(toField, model.to);
    parseObject.set(fromField, model.from);
    parseObject.set(membersField, [model.to, model.from]);

    final response = await parseObject.save();
    if (response.success) {
      // print('$className created ${parseObject.objectId}');
    } else {
      Utils.successSnackbar(
        title: 'Error',
        message: 'Error while creating $className: ${response.error}',
        error: true,
      );
    }

    // make sure there is a ChatConversation for this chat
    if (response.success) {
      final members = [model.to, model.from];
      final conversations = await ConversationUtils.query(members: members);

      if (conversations.isEmpty) {
        await ConversationUtils.upload(
          ParseChatConversationModel(members: members),
        );
      }
    }

    return response.success;
  }

  static Future<bool> delete(ParseChatMessageModel model) async {
    final parseObject = await parseObjectForModel(model: model, fetch: false);

    final response = await parseObject.delete();

    return response.success;
  }

  static Future<ParseObject> parseObjectForModel({
    required ParseChatMessageModel model,
    required bool fetch,
  }) {
    return ParseUtils.parseObjectForId(
      className: className,
      objectId: model.objectId,
      fetch: fetch,
    );
  }

  static ParseChatMessageModel? parseObjectToModel(ParseObject parseObject) {
    try {
      final map = ParseUtils.parseObjectToJson(parseObject: parseObject);

      if (map.isNotEmpty) {
        // replace 'image' file with the files url
        final file = parseObject.get<ParseFileBase>(imageField);
        map[imageField] = file?.url ?? '';

        return ParseChatMessageModel.fromJson(map);
      }
    } catch (err) {
      print(err);
    }

    return null;
  }

  static QueryBuilder<ParseObject> _buildQuery({
    required String from,
    required String to,
  }) {
    return QueryBuilder<ParseObject>(
        ParseObject(ParseChatMessageUtils.className),
      )
      ..orderByAscending('createdAt')
      ..whereArrayContainsAll(ParseChatMessageUtils.membersField, [from, to]);
  }

  static ParseLiveQuery<ParseChatMessageModel> liveQuery({
    required String from,
    required String to,
  }) {
    final queryBuilder = _buildQuery(to: to, from: from);

    return ParseLiveQuery<ParseChatMessageModel>(
      query: queryBuilder,
      hasDescendingSort: false,
      disableUpdates: false,
      converter: (object) {
        return ParseChatMessageUtils.parseObjectToModel(object)!;
      },
    );
  }

  static Future<List<ParseChatMessageModel>> query({
    required String from,
    required String to,
  }) async {
    final queryBuilder = _buildQuery(to: to, from: from);

    final result = <ParseChatMessageModel>[];

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

  static String initialsForUsername(String username) {
    var result = '?';

    if (username.isNotEmpty) {
      result = username[0];

      final names = username.split(' ');
      if (names.length > 1) {
        final lastName = names.last;

        if (lastName.isNotEmpty) {
          result += lastName[0];
        }
      } else {
        if (username.length > 1) {
          result += username[1];
        }
      }
    }

    return result.toUpperCase();
  }
}
