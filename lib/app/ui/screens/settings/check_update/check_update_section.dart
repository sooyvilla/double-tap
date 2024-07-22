import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import '../../../ui.dart';

class CheckUpdateSection extends ConsumerWidget {
  const CheckUpdateSection({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final settingsCheckerState = ref.watch(settingsCheckerProvider);
    return ContainerGreyColumn(
      titleSection: 'Updates',
      children: [
        Row(
          children: [
            Expanded(
              child: ButtonPrimary(
                text: 'Check updates',
                onPressed: () {
                  ref.read(settingsCheckerProvider.notifier).checkUpdates();
                },
              ),
            ),
            // const Spacer(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextWithPadding(
                    text: settingsCheckerState.isUpdateAvailable
                        ? 'New version:'
                        : 'Current version: ',
                    right: 0,
                    left: 0,
                    style: textNormal,
                  ),
                  TextWithPadding(
                    text: settingsCheckerState.isUpdateAvailable
                        ? settingsCheckerState.newVersion ?? ''
                        : settingsCheckerState.currentVersion ?? '',
                    left: 0,
                    style: subTitleGrey,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (settingsCheckerState.isUpdateAvailable)
          ButtonPrimary(
            text: 'Install',
            textAlign: TextAlign.right,
            onPressed: () {
              ref.read(settingsCheckerProvider.notifier).checkUpdates();
            },
          ),
      ],
    );
  }
}
