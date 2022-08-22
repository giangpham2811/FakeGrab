// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._privateConstructor();

  static final AppPreferences _instance = AppPreferences._privateConstructor();

  factory AppPreferences() {
    SharedPreferences.getInstance().then((value) {
      _instance._preference = value;
    });
    return _instance;
  }

  SharedPreferences? _preference;

  static const String KEY_APP_LANGUAGE = "KEY_APP_LANGUAGE";

  String? get appLanguage {
    return _preference?.getString(KEY_APP_LANGUAGE);
  }

  void saveAppLanguage(String language) {
    _preference?.setString(KEY_APP_LANGUAGE, language);
  }
}

AppPreferences appPreferences = AppPreferences();
