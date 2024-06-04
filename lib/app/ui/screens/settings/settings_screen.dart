import 'package:flutter/material.dart';

import '../../ui.dart';
import 'account/account_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPrimary(
      appBarText: 'Account',
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AccountSection(),
          ],
        ),
      ),
    );
  }
}
