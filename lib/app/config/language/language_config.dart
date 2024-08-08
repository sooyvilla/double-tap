import 'package:double_tap/app/config/config.dart';
import 'package:double_tap/app/config/language/language_model.dart';

part 'language_maps.dart';

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

  void initializeLanguage() {
    final lan = _prefs.getString('language') ?? 'en';
    _language = _getLanguageName(lan);
    _loadLanguageModel(lan);
  }

  void _loadLanguageModel(String language) {
    switch (language) {
      case 'en':
        _languageModel = LanguageModel.fromJson(en);
        break;
      case 'es':
        _languageModel = LanguageModel.fromJson(es);
        break;
    }
  }

  void switchLanguage(String language) {
    final lan = _getLanguageByName(language);
    if (_supportedLanguages.contains(lan)) {
      _language = _getLanguageName(lan);
      _prefs.setString('language', lan);
      _loadLanguageModel(lan);
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
