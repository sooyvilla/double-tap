import 'package:double_tap/app/config/language/language_config.dart';
import 'package:double_tap/app/ui/ui.dart';
import 'package:double_tap/main.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class LanguageOption extends StatelessWidget {
  const LanguageOption({super.key});

  @override
  Widget build(BuildContext context) {
    final languageList = LanguageConfig().supportedLanguages;
    final selectedLanguage = LanguageConfig().currentLanguage;
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextWithPadding(
              text: language.settings.optionsSection.languageOption.text,
              style: textNormal,
            ),
            const Spacer(),
            DropdownButton<String>(
              value: selectedLanguage,
              style: textNormal.copyWith(
                color: primaryRed,
                fontWeight: FontWeight.bold,
              ),
              enableFeedback: true,
              dropdownColor: primaryGrey,
              underline: Container(),
              icon: Container(),
              menuMaxHeight: height * 0.3,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              borderRadius: BorderRadius.circular(8),
              onChanged: (value) {
                if (value == null) return;
                if (value == selectedLanguage) return;
                LanguageConfig().switchLanguage(value);
                Restart.restartApp();
              },
              items: languageList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(
                    child: Text(value),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
