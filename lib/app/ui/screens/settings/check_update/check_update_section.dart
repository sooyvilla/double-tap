import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restart_app/restart_app.dart';

import '../../../providers/providers.dart';
import '../../../ui.dart';

class CheckUpdateSection extends ConsumerStatefulWidget {
  const CheckUpdateSection({super.key});

  @override
  ConsumerState<CheckUpdateSection> createState() => _CheckUpdateSectionState();
}

class _CheckUpdateSectionState extends ConsumerState<CheckUpdateSection> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(settingsCheckerProvider.notifier).init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingsCheckerState = ref.watch(settingsCheckerProvider);

    if (settingsCheckerState.isLoading) {
      return const ContainerGreyColumn(
        titleSection: 'Updates',
        children: [
          CircularLoad(),
        ],
      );
    }

    return Column(
      children: [
        ContainerGreyColumn(
          titleSection: 'Updates',
          children: [
            Row(
              children: [
                Expanded(
                  child: ButtonPrimary(
                    text: 'Check updates',
                    onPressed: () {
                      ref
                          .read(settingsCheckerProvider.notifier)
                          .checkPatchUpdates();
                    },
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextWithPadding(
                        text: settingsCheckerState.isUpdateAvailable
                            ? 'New version available'
                            : 'Patch version: ',
                        right: 0,
                        left: 0,
                        style: textNormal,
                      ),
                      TextWithPadding(
                        text: settingsCheckerState.currentVersionPatch,
                        left: 0,
                        style: subTitleGrey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const TextWithPadding(
                        text: 'Version app: ',
                        right: 0,
                        style: textNormal,
                      ),
                      TextWithPadding(
                        text: '1.1.0',
                        left: 0,
                        style: textNormalGrey,
                      ),
                    ],
                  ),
                ),
                if (settingsCheckerState.isUpdateAvailable)
                  Expanded(
                    child: ButtonPrimary(
                      text: settingsCheckerState.isUpdateDownloaded
                          ? 'Restar app'
                          : 'Install',
                      textAlign: TextAlign.right,
                      onPressed: () {
                        settingsCheckerState.isUpdateDownloaded
                            ? Restart.restartApp()
                            : ref
                                .read(settingsCheckerProvider.notifier)
                                .downloadUpdate();
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
        if (settingsCheckerState.updates.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: settingsCheckerState.updates.length,
            itemBuilder: (context, index) {
              final update = settingsCheckerState.updates[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextWithPadding(
                        text: update.title,
                        top: 0,
                        left: 5,
                        bottom: 5,
                        style: textTitle.copyWith(fontSize: 16),
                      ),
                      TextWithPadding(
                        text: update.version,
                        left: 0,
                        top: 0,
                        bottom: 5,
                        style: textNormalGrey.copyWith(
                          fontSize: 16,
                          color: Colors.green[200],
                        ),
                      ),
                    ],
                  ),
                  TextWithPadding(
                    text: update.date,
                    top: 0,
                    left: 8,
                    bottom: 5,
                    style: textNormalGrey.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  TextWithPadding(
                    text: update.desc,
                    top: 0,
                    left: 8,
                    style: textNormalGrey.copyWith(fontSize: 14),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}
