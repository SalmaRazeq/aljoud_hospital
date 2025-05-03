import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  // Data or state
  String currentLanguage = 'en';

  // Update language and save it
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

    // Update current language based on saved preference
    currentLanguage = lang;
    notifyListeners();
  }

  // Get the locale based on current language
  Locale get locale {
    return Locale(currentLanguage, currentLanguage == 'ar' ? 'AE' : 'US');
  }
}
