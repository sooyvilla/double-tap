import 'package:flutter/material.dart';

import '../../ui.dart';
import 'account/account_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPrimary(
      appBarText: 'Account',
      body: WidgetBody(
        children: [
          AccountSection(),
        ]
      ),
    );
  }
}

