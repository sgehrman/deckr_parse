import 'package:deckr_parse/src/db_models/parse_user_model.dart';
import 'package:deckr_parse/src/parse_utils.dart';
import 'package:deckr_parse/src/user_utils.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ParseUserProvider extends ChangeNotifier {
  factory ParseUserProvider() {
    return _instance ??= ParseUserProvider._();
  }

  ParseUserProvider._() {
    sync();
  }

  static ParseUserProvider? _instance;
  bool _isAdmin = false;
  ParseUser? _user;
  ParseUserModel? _userModel;

  Future<void> sync() async {
    _isAdmin = false;
    _user = await ParseUtils.getUser();

    if (_user != null) {
      _isAdmin = await _userIsAdmin();

      _userModel = UserUtils.parseObjectToModel(_user!);

      // Checks whether the user's session token is valid
      final response = await ParseUser.getCurrentUserFromServer(
        _user!.sessionToken ?? '',
      );

      if (response != null) {
        if (!response.success) {
          // Invalid session. Logout, this should call sync again and clear the _user
          // don't sign out if network error

          // we use to signOut here, but this gets called if their wifi is down
          // saw otherCause when wifi was down, not sure if this is the best way to handle it
          // but test and see if this works, or just remove the signOut?
          if (response.error != null &&
              response.error?.code != ParseError.otherCause &&
              response.error?.code != ParseError.connectionFailed &&
              response.error?.code != ParseError.internalServerError &&
              response.error?.code != ParseError.timeout) {
            print('Signing out user due to error: ${response.error}');
            await ParseUtils.signOut();
          } else {
            print('User not signed out: ${response.error}');
          }
        } else {
          ParseUtils.parseHost.onChange();
        }
      }
    }

    notifyListeners();
  }

  Future<bool> _userIsAdmin() async {
    final function = ParseCloudFunction('isAdmin');
    final parseResponse = await function.execute();

    if (parseResponse.success && parseResponse.result != null) {
      return parseResponse.result as bool? ?? false;
    }

    return false;
  }

  Future<bool> signedInAsync() async {
    await sync();

    return signedIn;
  }

  bool get signedIn => _user != null;
  bool get isAdmin => _isAdmin;
  ParseUser? get user => _user;

  ParseUserModel? get userModel => _userModel;
  String get email => _userModel?.email ?? '';
  String get licenseKey => _userModel?.licenseKey ?? '';
  bool get blueCheck => _userModel?.blueCheck ?? false;
  String get username => _userModel?.username ?? '';
  String get userId => _userModel?.objectId ?? '';
  String get avatar => _userModel?.avatar ?? '';
}
