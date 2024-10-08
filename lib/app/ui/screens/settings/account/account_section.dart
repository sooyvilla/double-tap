import 'package:double_tap/app/config/config.dart';
import 'package:double_tap/app/ui/screens/settings/account/account_webview.dart';
import 'package:double_tap/app/ui/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../main.dart';
import '../../../providers/providers.dart';
import '../../../ui.dart';

class AccountSection extends ConsumerWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(settingsAccountProvider);

    Future<void> alert() async => await showAlertCupertino(
          context,
          language.settings.accountSection.infoButton.title,
          language.settings.accountSection.infoButton.desc,
        );

    return ContainerGreyColumn(
      titleSection: language.settings.accountSection.title,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (user.isLoading) const CircularLoad(),
        if (!user.isLoggedIn &&
            !user.isLoading &&
            (user.accounts?.isEmpty ?? true))
          TextWithPadding(
            text: language.settings.accountSection.notLogginAccount,
          ),
        if (!user.isLoading && (user.accounts?.isNotEmpty ?? false))
          ListView.builder(
            itemCount: 1,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final account = user.accounts!.first;
              return GestureDetector(
                onTap: () async {
                  if (account.isLoggedIn) {
                    return;
                  }
                  await ref
                      .read(settingsAccountProvider.notifier)
                      .switchAccount(account.isarId!);
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (account.isLoggedIn)
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.check,
                              color: primaryRed,
                              size: 20,
                            ),
                          ),
                        TextWithPadding(
                          text: account.showName,
                          right: 0,
                          left: account.isLoggedIn ? 4 : 12,
                          style: textNormal,
                        ),
                        Expanded(
                          child: TextWithPadding(
                            text: ' #${account.tagLine}',
                            left: 0,
                            style: textNormalGrey,
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(12),
                        //   child: GestureDetector(
                        //     onTap: () async {
                        //       showModalCupertino(
                        //         context,
                        //         account.showName,
                        //         rememberAccount: true,
                        //         onPressedPrimary: () async {
                        //           await ref
                        //               .read(settingsAccountProvider.notifier)
                        //               .logout(account.isarId!);
                        //         },
                        //         onPressedSecondary: () async {
                        //           await ref
                        //               .read(settingsAccountProvider.notifier)
                        //               .logoutAndRemember(account.isarId!);
                        //           ref.read(liveProvider.notifier).cleanAll();
                        //         },
                        //       );
                        //     },
                        //     child: Icon(
                        //       Icons.exit_to_app,
                        //       color: primaryRed,
                        //       size: 20,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    // if (index != user.accounts!.length - 1)
                    //   const DividerCustom(),
                  ],
                ),
              );
            },
          ),
        if (!user.isLoading)
          Row(
            children: [
              if (!user.isLoggedIn)
                Expanded(
                  child: ButtonPrimary(
                    text: user.isLoggedIn || user.accounts != null
                        ? 'Add account'
                        : language.settings.accountSection.loginButton,
                    onPressed: () async {
                      final prefs = SharedPreferencesConfig.prefs!;
                      final showAlert = prefs.getBool('alert') ?? true;

                      if (showAlert) {
                        prefs.setBool('alert', false);
                        await alert();
                      }

                      showModal(
                        // ignore: use_build_context_synchronously
                        context,
                        const AccountWebview(),
                      );
                    },
                  ),
                ),
              const Spacer(),
              // if (user.isLoggedIn)
              //   Expanded(
              //     child: ButtonPrimary(
              //       text: (user.accounts?.length ?? 0) > 1
              //           ? 'Logout all'
              //           : 'Logout',
              //       // ceroPadding: true,
              //       textAlign: TextAlign.right,
              //       onPressed: () async {
              //         showModalCupertino(
              //           context,
              //           'all',
              //           onPressedPrimary: () async {
              //             await ref
              //                 .read(settingsAccountProvider.notifier)
              //                 .logoutAll();
              //             ref.read(liveProvider.notifier).cleanAll();
              //           },
              //         );
              //       },
              //     ),
              //   ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    alert();
                  },
                  icon: const Icon(Icons.help_outline_rounded),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
