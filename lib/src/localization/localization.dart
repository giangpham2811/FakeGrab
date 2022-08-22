// ignore_for_file: constant_identifier_names

import 'package:app/src/data/preferences/app_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'csv_loader/csv_asset_loader.dart';

const String LANGUAGE_EN = "en";
const String LANGUAGE_TH = "th";

class Localization {
  static const String DEFAULT_LANGUAGE = LANGUAGE_EN;

  static Widget buildLocalizationWidget({app}) {
    final appLanguage = getAppLanguage();
    _updateAppLocale(appLanguage);
    return EasyLocalization(
        supportedLocales: const [Locale(LANGUAGE_EN), Locale(LANGUAGE_TH)],
        path: 'lib/res/translations/langs.csv',
        fallbackLocale: const Locale(DEFAULT_LANGUAGE),
        startLocale: Locale(appLanguage),
        assetLoader: CsvAssetLoader(),
        child: app);
  }

  static String getAppLanguage() {
    return AppPreferences().appLanguage ?? DEFAULT_LANGUAGE;
  }

  static bool isAppLanguageEn() {
    return getAppLanguage() == LANGUAGE_EN;
  }

  static bool isAppLanguageTh() {
    return getAppLanguage() == LANGUAGE_TH;
  }

  static changeAppLanguage(BuildContext context, String newAppLanguage) {
    context.setLocale(Locale(newAppLanguage));
    _updateAppLocale(newAppLanguage);
    appPreferences.saveAppLanguage(newAppLanguage);
  }

  static toggleAppLanguage(BuildContext context) {
    final String newAppLanguage = isAppLanguageEn() ? LANGUAGE_TH : LANGUAGE_EN;
    context.setLocale(Locale(newAppLanguage));
    _updateAppLocale(newAppLanguage);
    appPreferences.saveAppLanguage(newAppLanguage);
  }

  static changeAppLanguageToDefault(BuildContext context) {
    context.setLocale(const Locale(DEFAULT_LANGUAGE));
    _updateAppLocale(DEFAULT_LANGUAGE);
    appPreferences.saveAppLanguage(DEFAULT_LANGUAGE);
  }

  static _updateAppLocale(String locale) {
    Intl.defaultLocale = locale;
    Intl.systemLocale = locale;
  }
}
