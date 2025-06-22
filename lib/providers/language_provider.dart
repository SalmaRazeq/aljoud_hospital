import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLanguage = 'en';
  void changeAppLanguage(String newLang) {
    if (currentLanguage == newLang) return;
    currentLanguage = newLang;
    saveLang(newLang); // Save language preference
    notifyListeners();
  }
  void saveLang(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', lang);  // Save the selected language
  }
  Future<void> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('lang') ?? 'en';  // Default to 'en'
    currentLanguage = lang;
    notifyListeners();
  }
  Locale get locale {
    return Locale(currentLanguage, currentLanguage == 'ar' ? 'AE' : 'US');
  }
}
