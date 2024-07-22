import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import 'app/config/config.dart';
import 'app/ui/widgets/widgets.dart';

final shorebirdCodePush = ShorebirdCodePush();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesConfig.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    shorebirdCodePush
        .currentPatchNumber()
        .then((value) => log('current patch number is $value'));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkForUpdates();
    });
    super.initState();
  }

  Future<void> _checkForUpdates() async {
    final isUpdateAvailable =
        await shorebirdCodePush.isNewPatchAvailableForDownload();

    if (isUpdateAvailable) {
      await shorebirdCodePush.downloadUpdateIfAvailable().then((value) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text('Actualización disponible'),
              content: const Text(
                  'Una nueva actualización está disponible. Reinicia la aplicación para aplicar los cambios.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    SystemNavigator.pop();
                  },
                  child: const Text('Reiniciar'),
                ),
              ],
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkForUpdates(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularLoad(),
            ),
          );
        }
        return const NavigationbarCustom();
      },
    );
  }
}
