import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restart_app/restart_app.dart';

import '../../../../config/config.dart';
import '../../../providers/providers.dart';
import '../../../ui.dart';
import 'version_patch_widget.dart';

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
                        text: settingsCheckerState.currentVersion ?? '',
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
          ShowListUpdatesNotesWidget(
            updates: settingsCheckerState.updates,
          ),
      ],
    );
  }
}
