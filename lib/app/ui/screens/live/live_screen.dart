import 'package:double_tap/app/ui/providers/providers.dart';
import 'package:double_tap/app/ui/ui.dart';
import 'package:double_tap/app/ui/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../settings/account/account_webview.dart';
import 'store/store_section.dart';
import 'user/user_section.dart';

class LiveScreen extends ConsumerWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsAccountProvider);

    if (settings.showAlertStatusSesion) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(settingsAccountProvider.notifier)
            .setShowAlertStatusSesion(false);
        showAlertCupertino(
          context,
          language.alertSession.title,
          language.alertSession.desc,
          onPressedPrimary: () {
            Navigator.of(context).pop();
            showModal(
              context,
              const AccountWebview(),
            );
          },
          onPressedSecondary: () async {
            ref.read(liveProvider.notifier).cleanAll();
            await ref.read(settingsAccountProvider.notifier).logoutAll();
          },
        );
      });
    }

    return ScaffoldPrimary(
      appBarText: language.live.appBarTitle,
      body: const WidgetBody(
        children: [
          PlaySection(),
          StoreSection(),
          // InventorySection(),
        ],
      ),
    );
  }
}
