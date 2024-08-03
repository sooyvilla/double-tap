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

  final prefs = SharedPreferencesConfig.prefs!;

  final _supportedLanguages = ['en', 'es'];
  late String _language;

  List<String> get supportedLanguages => _supportedLanguages;
  String get currentLanguage => _language;
  LanguageModel get languageModel => _languageModel;

  Future<void> initializeLanguage() async {
    _language = prefs.getString('language') ?? 'en';
    await _loadLanguageModel(_language);
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
    if (_supportedLanguages.contains(language)) {
      _language = language;
      prefs.setString('language', language);
      await _loadLanguageModel(_language);
    }
  }
}
