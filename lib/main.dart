import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/config/config.dart';
import 'app/ui/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await SharedPreferencesConfig.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Double Tap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.black,
          background: Colors.black,
          onBackground: Colors.black,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onTertiary: Colors.black,
          onError: Colors.black,
          onSurface: Colors.white,
          onSurfaceVariant: Colors.white,
          onInverseSurface: Colors.black,
          error: Colors.black,
          errorContainer: Colors.black,
          onErrorContainer: Colors.black,
          inversePrimary: Colors.black,
          onPrimaryContainer: Colors.black,
          primaryContainer: Colors.black,
          secondary: Colors.black,
          secondaryContainer: Colors.black,
          tertiary: Colors.black,
          tertiaryContainer: Colors.black,
          inverseSurface: Colors.black,
          onSecondaryContainer: Colors.black,
          onTertiaryContainer: Colors.black,
          outline: Colors.black,
          outlineVariant: Colors.black,
          primary: Colors.white,
          scrim: Colors.black,
          shadow: Colors.black,
          surface: Colors.black,
          surfaceVariant: Colors.black,
          surfaceTint: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const NavigationbarCustom(),
    );
  }
}
