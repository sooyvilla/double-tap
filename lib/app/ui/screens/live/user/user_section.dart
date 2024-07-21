import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import '../../../ui.dart';

class PlaySection extends ConsumerWidget {
  const PlaySection({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(settingsProvider);
    return ContainerGreyColumn(
      titleSection: 'User',
      children: [
        if (user.isLoggedIn)
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
        if (!user.isLoggedIn)
          const Column(
            children: [
              Icon(Icons.person, size: 80),
              // SizedBox(height: 10),
              TextWithPadding(
                text: 'Not signed in yet',
                style: textTitle,
              ),
            ],
          )
      ],
    );
  }
}
