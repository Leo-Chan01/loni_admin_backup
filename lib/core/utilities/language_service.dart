import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _localeKey = 'app_locale';

  Future<Locale?> getSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localeCode = prefs.getString(_localeKey);
      if (localeCode == null) return null;
      return Locale(localeCode);
    } catch (e) {
      debugPrint('Error loading saved locale: $e');
      return null;
    }
  }

  Future<void> saveLocale(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
    } catch (e) {
      debugPrint('Error saving locale: $e');
    }
  }

  Future<void> clearLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_localeKey);
    } catch (e) {
      debugPrint('Error clearing locale: $e');
    }
  }
}
