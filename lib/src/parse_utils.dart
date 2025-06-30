import 'dart:typed_data';

import 'package:deckr_parse/src/parse_user_provider.dart';
import 'package:dfc_flutter/dfc_flutter_web.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// ===========================================================
// subclass ParseHost

abstract class ParseHost {
  String get appId;
  String get clientKey;
  String get serverUrl;
  String get liveQueryUrl;

  void onChange();

  String get emailPref;
  set emailPref(String value);

  String get usernamePref;
  set usernamePref(String value);
}

// ===========================================================

class ParseUtils {
  ParseUtils._();

  static late ParseHost _parseHost;
  static ParseHost get parseHost => _parseHost;

  static Future<void> initialize(ParseHost host) async {
    WidgetsFlutterBinding.ensureInitialized();

    _parseHost = host;

    await Parse().initialize(
      host.appId,
      host.serverUrl,
      liveQueryUrl: host.liveQueryUrl,
      clientKey: host.clientKey,
      // debug: Utils.debugBuild,
    );
  }

  static Future<bool> resetPassword({required String email}) async {
    final user = ParseUser(
      null,
      null,
      email.trim(),
      // debug: Utils.debugBuild,
    );
    final response = await user.requestPasswordReset();

    if (response.success) {
      Utils.successSnackbar(
        title: 'Success',
        message: 'Password reset instructions have been sent to email',
      );
    } else {
      Utils.successSnackbar(
        title: 'Error',
        message: response.error!.message,
        error: true,
      );

      ParseUtils.printParseError(response, contextInfo: 'resetPassword failed');
    }

    return response.success;
  }

  static Future<bool> createUser({
    required String username,
    required String password,
    required String email,
  }) async {
    final user = ParseUser.createUser(username, password, email);

    final response = await user.signUp();

    if (response.success) {
      Utils.successSnackbar(
        title: 'Success',
        message: 'Account created for $username',
      );
    } else {
      Utils.successSnackbar(
        title: 'Error',
        message: response.error!.message,
        error: true,
      );

      ParseUtils.printParseError(response, contextInfo: 'createUser failed');
    }

    return response.success;
  }

  static Future<bool> signIn({
    required String username,
    required String password,
  }) async {
    final user = ParseUser(username, password, null);

    final response = await user.login();

    if (response.success) {
      Utils.successSnackbar(
        title: 'Success',
        message: 'Welcome back $username',
      );

      await ParseUserProvider().sync();
    } else {
      Utils.successSnackbar(
        title: 'Error',
        message: response.error!.message,
        error: true,
      );

      ParseUtils.printParseError(response, contextInfo: 'signIn failed');
    }

    return response.success;
  }

  static Future<bool> signOut() async {
    final currentUser = await getUser();
    if (currentUser == null) {
      return false;
    }

    final username = currentUser.username;
    final response = await currentUser.logout();

    if (response.success) {
      Utils.successSnackbar(title: 'Success', message: 'Signed out $username');

      await ParseUserProvider().sync();
    } else {
      Utils.successSnackbar(
        title: 'Error',
        message: response.error!.message,
        error: true,
      );

      ParseUtils.printParseError(response, contextInfo: 'signOut failed');
    }

    return response.success;
  }

  static Future<ParseFileBase?> uploadImageDataReturnUrl({
    required Uint8List imageData,
    required bool saveAsJpg,
    int maxWidth = 1024,
  }) async {
    final processedData = await processImageForUpload(
      imageData,
      saveAsJpg: saveAsJpg,
      maxWidth: maxWidth,
    );

    var imageName = Utils.uniqueFirestoreId();
    if (saveAsJpg) {
      imageName = '$imageName.jpg';
    } else {
      imageName = '$imageName.png';
    }

    final parseFile = ParseWebFile(processedData, name: imageName);

    final response = await parseFile.save();

    if (response.success) {
      return parseFile;
    } else {
      ParseUtils.printParseError(response, contextInfo: 'save image failed');
    }

    return null;
  }

  static Future<Uint8List> processImageForUpload(
    Uint8List imageData, {
    required bool saveAsJpg,
    required int maxWidth,
  }) async {
    var image = img.decodeImage(imageData)!;

    // shrink image
    if (image.width > maxWidth) {
      image = img.copyResize(
        image,
        width: maxWidth,
        interpolation: img.Interpolation.average,
      );
    }

    Uint8List data;

    if (saveAsJpg) {
      data = img.encodeJpg(image, quality: 70);
    } else {
      data = img.encodePng(image, level: 5);
    }

    return data;
  }

  static Future<ParseUser?> getUser() async {
    final result = await ParseUser.currentUser();

    if (result != null) {
      return result as ParseUser;
    }

    return null;
  }

  // ----------------------------------------------------

  static Future<String> getUserId() async {
    final user = await getUser();

    if (user != null) {
      return user.objectId ?? '';
    }

    return '';
  }

  // ----------------------------------------------------

  static Future<ParseUser?> userWithId(String userId) async {
    final query = QueryBuilder<ParseUser>(ParseUser.forQuery());

    query.whereEqualTo('objectId', userId);

    final result = await query.find();

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }

  // ----------------------------------------------------

  // if you just have the id, this will create and fetch the object
  static Future<ParseObject> parseObjectForId({
    required String objectId,
    required String className,
    bool fetch = true,
  }) async {
    final result = ParseObject(className)..objectId = objectId;

    if (fetch) {
      await result.fetch();
    }

    return result;
  }

  // ----------------------------------------------------

  static Future<String> usernameForEmail({required String email}) async {
    final function = ParseCloudFunction('usernameForEmail');
    final parseResponse = await function.execute(parameters: {'email': email});

    if (parseResponse.success && parseResponse.result != null) {
      return parseResponse.result as String;
    }

    return '';
  }

  // ----------------------------------------------------
  // convert parseObject to json

  static dynamic normalizeValue(dynamic item) {
    dynamic result;

    if (item == null) {
      // print('null');
    } else if (item is Iterable) {
      final list = <dynamic>[];

      for (final i in item) {
        list.add(normalizeValue(i));
      }

      result = list;
    } else if (item is Map) {
      final map = <dynamic, dynamic>{};

      // get the type.  could be a file, or an array
      final className = item['className'] as String? ?? '';

      switch (className) {
        case 'ParseArray':
          result = item['estimatedArray'] as List? ?? [];
          break;
        case 'ParseNumber':
          result = item['estimateNumber'] as int? ?? 0;
          break;
      }

      if (result == null) {
        for (final key in item.keys) {
          map[key] = normalizeValue(item[key]);
        }

        result = map;
      }
    } else {
      result = item;
    }

    return result;
  }

  // ----------------------------------------------------
  // NOTE: only works for saved values from server

  static Map<String, dynamic> parseObjectToJson({
    required ParseObject parseObject,
    bool full = false,
  }) {
    final result = <String, dynamic>{};

    final map = parseObject.toJson(full: full);

    for (final key in map.keys) {
      final item = map[key];

      result[key] = normalizeValue(item);
    }

    return result;
  }

  static void printParseError(
    ParseResponse response, {
    required String contextInfo,
  }) {
    if (response.success) {
      // this can be called if results == null
      if (response.results != null) {
        if (contextInfo.isNotEmpty) {
          print(contextInfo);
        }
        print('Parse Response Success but results not null?: $response');
      }
    } else {
      final code = response.error?.code ?? 0;

      // Don't log Code: 1
      // Message: Successful request, but no results found

      if (code != 1) {
        if (contextInfo.isNotEmpty) {
          print(contextInfo);
        }
        print('Parse Error: ${response.error ?? response}');
      }
    }
  }
}
