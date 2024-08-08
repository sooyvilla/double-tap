import 'package:double_tap/app/config/config.dart';
import 'package:double_tap/app/ui/screens/settings/check_update/check_update_section.dart';
import 'package:double_tap/app/ui/screens/settings/language/language_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../../providers/providers.dart';
import '../../ui.dart';
import 'account/account_section.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen>
    with WidgetsBindingObserver {
  final prefs = SharedPreferencesConfig.prefs!;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(settingsAccountProvider.notifier).validateSession();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final timeToRefresh = prefs.getString('timeToRefresh');
      if (timeToRefresh != null) {
        final time = DateTime.parse(timeToRefresh);
        final now = DateTime.now();
        if (now.difference(time).inMinutes > 10) {
          ref.read(settingsAccountProvider.notifier).validateSession();
        }
      }
    } else if (state == AppLifecycleState.paused) {
      prefs.setString('timeToRefresh', DateTime.now().toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPrimary(
      appBarText: language.settings.settingsSection.title,
      body: const WidgetBody(
        children: [
          AccountSection(),
          CheckUpdateSection(),
          LanguageSection(),
        ],
      ),
    );
  }
}
