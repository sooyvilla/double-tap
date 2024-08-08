import 'dart:developer';

import 'package:double_tap/app/config/config.dart';
import 'package:double_tap/app/config/language/language_model.dart';
import 'package:flutter/services.dart';

class LanguageConfig {
  static final LanguageConfig _instance = LanguageConfig._internal();
  late LanguageModel _languageModel;

  factory LanguageConfig() {
    return _instance;
  }

  LanguageConfig._internal();

  final _prefs = SharedPreferencesConfig.prefs!;

  final _supportedLanguages = ['en', 'es'];
  final _listLanguage = ['English', 'Español'];
  late String _language;

  List<String> get supportedLanguages => _listLanguage;
  String get currentLanguage => _language;
  LanguageModel get languageModel => _languageModel;

  Future<void> initializeLanguage() async {
    final lan = _prefs.getString('language') ?? 'en';
    _language = _getLanguageName(lan);
    await _loadLanguageModel(lan);
  }

  Future<void> _loadLanguageModel(String language) async {
    try {
      final String jsonString = await rootBundle
          .loadString('assets/language/$language/language.json');
      _languageModel = LanguageModel.fromRawJson(jsonString);
    } catch (e) {
      log('Error loading language model: $e');
      if (language != 'en') {
        await _loadLanguageModel('en');
      } else {
        throw Exception('Default language file missing or corrupted');
      }
    }
  }

  Future<void> switchLanguage(String language) async {
    final lan = _getLanguageByName(language);
    if (_supportedLanguages.contains(lan)) {
      _language = _getLanguageName(lan);
      _prefs.setString('language', lan);
      await _loadLanguageModel(lan);
    }
  }

  String _getLanguageName(String language) {
    final index = _supportedLanguages.indexOf(language);
    return _listLanguage[index];
  }

  String _getLanguageByName(String language) {
    final index = _listLanguage.indexOf(language);
    return _supportedLanguages[index];
  }
}
