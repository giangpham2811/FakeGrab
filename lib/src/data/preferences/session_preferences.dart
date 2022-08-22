// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:app/src/data/model/account.dart';
import 'package:app/src/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionPreferences {
  // Singleton
  SessionPreferences._privateConstructor();

  static final SessionPreferences _instance = SessionPreferences._privateConstructor();

  factory SessionPreferences() {
    return _instance;
  }

  // Shared instance
  final Future<SharedPreferences> _sharedPreference = SharedPreferences.getInstance();

  static const String KEY_AUTH_TOKEN = "KEY_AUTH_TOKEN";
  static const String KEY_USER_PROFILE = "KEY_USER_PROFILE";

  Future<String?> get authToken async {
    return _sharedPreference.then((preference) {
      return preference.getString(KEY_AUTH_TOKEN);
    });
  }

  Future<User?> get userProfile async {
    return _sharedPreference.then((preference) {
      try {
        var userString = preference.getString(KEY_USER_PROFILE);
        return User.fromJson(json.decode(userString!));
      } catch (e) {
        logger.e(e);
      }
      return null;
    });
  }

  Future saveAuthToken(String authToken) async {
    return _sharedPreference.then((preference) {
      return preference.setString(KEY_AUTH_TOKEN, authToken);
    });
  }

  Future removeAuthToken() async {
    return _sharedPreference.then((preference) {
      return preference.remove(KEY_AUTH_TOKEN);
    });
  }

  Future saveUserProfile(User? user) async {
    return _sharedPreference.then((preference) {
      String userProfile;
      try {
        userProfile = json.encode(user?.toJson());
      } catch (e) {
        logger.e(e);
        userProfile = "";
      }
      return preference.setString(KEY_USER_PROFILE, userProfile);
    });
  }

  Future removeUserProfile() async {
    return _sharedPreference.then((preference) {
      return preference.remove(KEY_USER_PROFILE);
    });
  }

  Future<bool> isLoggedIn() async {
    return _sharedPreference.then((preference) {
      return preference.getString(KEY_AUTH_TOKEN)?.isNotEmpty ?? false;
    });
  }

  logout() async {
    await removeAuthToken();
    await removeUserProfile();
  }
}
