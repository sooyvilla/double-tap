import 'package:double_tap/app/ui/providers/providers.dart';
import 'package:double_tap/app/ui/ui.dart';
import 'package:double_tap/app/ui/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        showAlertCupertino(
            context, 'Accion necesaria', 'Debes ir a iniciar sesion de nuevo.',
            onPressed: () {
          ref
              .read(settingsAccountProvider.notifier)
              .setShowAlertStatusSesion(false);
          Navigator.of(context).pop();
          showModal(
            context,
            const AccountWebview(),
          );
        });
      });
    }

    return const ScaffoldPrimary(
      appBarText: 'Live',
      body: WidgetBody(
        children: [
          PlaySection(),
          StoreSection(),
          // InventorySection(),
        ],
      ),
    );
  }
}
