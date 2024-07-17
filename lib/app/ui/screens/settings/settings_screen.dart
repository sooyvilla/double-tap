import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../ui.dart';
import 'account/account_section.dart';

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
      ref.read(settingsProvider.notifier).validateSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPrimary(
      appBarText: 'Account',
      body: WidgetBody(
        children: [
          AccountSection(),
        ],
      ),
    );
  }
}
