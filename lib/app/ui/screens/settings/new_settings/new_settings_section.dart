import 'package:double_tap/app/ui/screens/settings/new_settings/options/language_option.dart';
import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../ui.dart';

class NewSettingsSection extends StatelessWidget {
  const NewSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerGreyColumn(
      titleSection: language.settings.optionsSection.title,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        LanguageOption(),
      ],
    );
  }
}
