import 'package:double_tap/app/config/language/language_config.dart';
import 'package:double_tap/app/ui/theme/colors.dart';
import 'package:double_tap/app/ui/theme/text_styles.dart';
import 'package:double_tap/app/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:restart_app/restart_app.dart';

class LanguageSection extends HookWidget {
  // Cambié a HookWidget
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageList = useValueNotifier(LanguageConfig().supportedLanguages);
    final selectedLanguage = useState<String>(LanguageConfig().currentLanguage);

    return ContainerGreyColumn(
      titleSection: 'Language',
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const TextWithPadding(
              text: 'Language: ',
              style: textNormal,
            ),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: languageList,
              builder: (_, list, __) {
                return GestureDetector(
                  onTap: () async {
                    final result = await showCupertinoModalPopup<String>(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        title: const Text('Selecciona un idioma'),
                        actions: list.map<Widget>((String valor) {
                          return CupertinoActionSheetAction(
                            child: Text(valor),
                            onPressed: () async {
                              await LanguageConfig().switchLanguage(valor);
                              Restart.restartApp();
                            },
                          );
                        }).toList(),
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    );

                    if (result != null) {
                      selectedLanguage.value = result;
                    }
                  },
                  child: TextWithPadding(
                    text: selectedLanguage.value,
                    style: textNormal.copyWith(
                      color: primaryRed,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
