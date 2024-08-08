import 'package:animate_do/animate_do.dart';
import 'package:double_tap/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restart_app/restart_app.dart';

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
      return ContainerGreyColumn(
        titleSection: language.settings.checkerSection.title,
        children: const [
          CircularLoad(),
        ],
      );
    }

    return Column(
      children: [
        ContainerGreyColumn(
          titleSection: language.settings.checkerSection.title,
          children: [
            Row(
              children: [
                Expanded(
                  child: ButtonPrimary(
                    text: language.settings.checkerSection.checkUpdatesButton,
                    onPressed: () {
                      ref
                          .read(settingsCheckerProvider.notifier)
                          .checkPatchUpdates();
                    },
                  ),
                ),
                if (settingsCheckerState.isUpdateAvailable)
                  Expanded(
                    child: Bounce(
                      infinite: true,
                      child: TextWithPadding(
                        text: language.settings.checkerSection.newVersion,
                        zeroPadding: true,
                        style: textNormal.copyWith(color: Colors.greenAccent),
                      ),
                    ),
                  ),
              ],
            ),
            Row(
              children: [
                if (!settingsCheckerState.isUpdateAvailable)
                  Expanded(
                    child: Row(
                      children: [
                        TextWithPadding(
                          text:
                              '${language.settings.checkerSection.versionApp} ',
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
                          ? language.settings.checkerSection.restarButton
                          : language.settings.checkerSection.installButton,
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
