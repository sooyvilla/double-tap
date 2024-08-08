import 'package:double_tap/app/config/language/language_model.dart';
import 'package:double_tap/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/config/config.dart';
import 'app/config/language/language_config.dart';
import 'app/ui/widgets/widgets.dart';

late LanguageModel language;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await SharedPreferencesConfig.init();

   LanguageConfig().initializeLanguage();

  language = LanguageConfig().languageModel;

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Double Tap',
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.getTheme(),
      home: const NavigationbarCustom(),
    );
  }
}
