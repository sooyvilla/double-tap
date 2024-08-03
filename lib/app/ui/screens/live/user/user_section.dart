import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/language/language_config.dart';
import '../../../providers/providers.dart';
import '../../../ui.dart';

class PlaySection extends ConsumerWidget {
  const PlaySection({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(settingsAccountProvider);
    final language = LanguageConfig().languageModel;
    return ContainerGreyColumn(
      titleSection: language.live.userSection.title,
      children: [
        if (user.isLoading) const CircularLoad(),
        if (user.isLoggedIn && !user.isLoading)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: [
                      Image.network(
                        user.user!.card!.wide!,
                      ),
                      const GradientWidget(),
                      Row(
                        children: [
                          TextWithPadding(
                            text: user.user!.username!,
                            right: 0,
                            top: 5,
                            style: textTitle,
                          ),
                          TextWithPadding(
                            text: ' #${user.user!.tagLine}',
                            left: 0,
                            top: 5,
                            style: textNormalGrey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        if (!user.isLoggedIn && !user.isLoading)
           Column(
            children: [
              Icon(Icons.person, size: 80),
              // SizedBox(height: 10),
              TextWithPadding(
                text: language.live.userSection.notLogginAccount,
                style: textTitle,
              ),
            ],
          )
      ],
    );
  }
}
