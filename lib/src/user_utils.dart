import 'package:deckr_parse/src/db_models/parse_user_model.dart';
import 'package:deckr_parse/src/parse_user_provider.dart';
import 'package:deckr_parse/src/parse_utils.dart';
import 'package:dfc_flutter/dfc_flutter_web.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UserUtils {
  UserUtils._();

  static const String kAvatarField = 'avatar';
  static const String kLicenseKeyField = 'licenseKey';
  static const String kBlueCheckField = 'blueCheck';

  static Future<bool> saveLicenseKey({required String licenseKey}) async {
    // don't update if we already have it in the User
    if (licenseKey == ParseUserProvider().licenseKey) {
      return true;
    }

    final user = await ParseUtils.getUser();

    if (user != null) {
      user.set(kLicenseKeyField, licenseKey);

      final response = await user.update();
      if (response.success) {
        await ParseUserProvider().sync();
      } else {
        print('Error while updating License key: ${response.error}');
      }
    }

    return false;
  }

  static Future<bool> saveBlueCheck({required bool blueCheck}) async {
    // don't update if we already have it in the User
    if (blueCheck == ParseUserProvider().blueCheck) {
      return true;
    }

    final user = await ParseUtils.getUser();

    if (user != null) {
      user.set(kBlueCheckField, blueCheck);

      final response = await user.update();
      if (response.success) {
        await ParseUserProvider().sync();
      } else {
        print('Error while updating blueCheck: ${response.error}');
      }
    }

    return false;
  }

  static Future<bool> updateUserAvatar(ParseFileBase avatarFile) async {
    final user = await ParseUtils.getUser();

    if (user != null) {
      user.set(kAvatarField, avatarFile);

      final response = await user.update();
      if (response.success) {
        Utils.successSnackbar(
          title: 'Success',
          message: 'User updated ${user.objectId}',
        );

        await ParseUserProvider().sync();
      } else {
        Utils.successSnackbar(
          title: 'Error',
          message: 'Error while updating User: ${response.error}',
          error: true,
        );

        print('Error while updating User: ${response.error}');
      }

      return response.success;
    }

    return false;
  }

  static ParseUserModel? parseObjectToModel(ParseObject parseObject) {
    try {
      final map = ParseUtils.parseObjectToJson(parseObject: parseObject);

      if (map.isNotEmpty) {
        // replace 'image' file with the files url
        final file = parseObject.get<ParseFileBase>(kAvatarField);
        map[kAvatarField] = file?.url ?? '';

        return ParseUserModel.fromJson(map);
      }
    } catch (err) {
      print(err);
    }

    return null;
  }

  // ----------------------------------------------------
}

// Parse.Cloud.define("editUserProperty", async (request) => {
//     const { objectId, newUsername } = request.params;
//     const User = Parse.Object.extend(Parse.User);
//     const query = new Parse.Query(User);
//     let result = await query.get(objectId, { useMasterKey: true });
//     if (!result) new Error("No user found!");

//     result.set("username", newUsername);
//     try {
//         result.save(null, { useMasterKey: true });
//         return "User updated successfully!";
//     } catch (e) {
//         return e.message;
//     }
// });
