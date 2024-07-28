import 'package:double_tap/app/ui/screens/settings/check_update/check_update_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../ui.dart';
import 'account/account_section.dart';
import 'account/account_webview.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(settingsAccountProvider.notifier).validateSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsAccountProvider);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: settings.showAccountWebView
          ? const SafeArea(
              child: AccountWebview(),
            )
          : const ScaffoldPrimary(
              appBarText: 'Settings',
              body: WidgetBody(
                children: [
                  AccountSection(),
                  CheckUpdateSection(),
                ],
              ),
            ),
    );
  }
}
