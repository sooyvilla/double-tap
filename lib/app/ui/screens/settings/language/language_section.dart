import 'package:double_tap/app/config/language/language_config.dart';
import 'package:double_tap/app/ui/theme/colors.dart';
import 'package:double_tap/app/ui/theme/text_styles.dart';
import 'package:double_tap/app/ui/widgets/widgets.dart';
import 'package:double_tap/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:restart_app/restart_app.dart';

class LanguageSection extends HookWidget {
  // Cambié a HookWidget
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageList = LanguageConfig().supportedLanguages;
    final selectedLanguage = LanguageConfig().currentLanguage;

    return ContainerGreyColumn(
      titleSection: language.settings.languageSection.title,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextWithPadding(
              text: language.settings.languageSection.text,
              style: textNormal,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                await showCupertinoModalPopup<String>(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: Text(
                      language.settings.languageSection.titleModal,
                      style: textNormalGrey,
                    ),
                    actions: languageList.map<Widget>((String valor) {
                      return CupertinoActionSheetAction(
                        child: Text(valor),
                        onPressed: () async {
                          LanguageConfig().switchLanguage(valor);
                          Restart.restartApp();
                        },
                      );
                    }).toList(),
                    cancelButton: CupertinoActionSheetAction(
                      child: Text(
                        language.settings.languageSection.cancelButton,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              },
              child: TextWithPadding(
                text: selectedLanguage,
                style: textNormal.copyWith(
                  color: primaryRed,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
