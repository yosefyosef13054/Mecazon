import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/localization/app_localization.dart';

const String ENGLISH = 'en';
const String FRENCH = 'fr';
const String ARABIC = 'ar';

String buildTranslate(BuildContext context, String key) =>
    AppLocalization.of(context)?.translate(key) ?? '';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(LAGUAGE_CODE) ?? 'fr';
  selectedLanguageCode = languageCode;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case 'en':
      return const Locale('en', 'US');
    case 'fr':
      return const Locale('fr', 'FR');
    case 'ar':
      return const Locale('ar', 'DZ');
    default:
      return const Locale('fr', 'FR');
  }
}

List<String> langCode = ['en', 'fr', 'ar'];

Future<Locale> changeLanguage(String selectedLanguageCode) async {
  var locale = await setLocale(selectedLanguageCode);
  return locale;
}

getCurrentLanguage({required BuildContext context}) async {
  // String getLanguage = await settingsProvider.getPrefrence(LAGUAGE_CODE) ?? '';
  // currentLanguage = langCode.indexOf(getLanguage == '' ? 'en' : getLanguage);
  // notifyListeners();
}
