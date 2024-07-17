import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import '../../../ui.dart';
import '../../../util/util.dart';
import 'login_form.dart';

class AccountSection extends ConsumerWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(settingsProvider);
    return ContainerGreyColumn(
      titleSection: 'Accounts',
      crossAxisAlignment: CrossAxisAlignment.start,
      children: user.isLoading
          ? [const CircularLoad()]
          : [
              if (!user.isLoggedIn)
                const TextWithPadding(text: 'Not signed in yet'),
              if (user.isLoggedIn)
                Row(
                  children: [
                    TextWithPadding(
                      text: user.user!.username!,
                      right: 0,
                      style: textNormal,
                    ),
                    TextWithPadding(
                      text: ' #${user.user!.tagLine}',
                      left: 0,
                      style: textNormalGrey,
                    ),
                  ],
                ),
              ButtonPrimary(
                text: user.isLoggedIn ? 'Logout' : 'Login',
                onPressed: () {
                  user.isLoggedIn
                      ? {
                          ref.read(settingsProvider.notifier).logout(),
                          ref.read(liveProvider.notifier).cleanAll(),
                        }
                      : showModal(context, const LoginForm());
                  // ValorantApiMatchHistoryDatasource().getMatchHistory();
                },
              ),
            ],
    );
  }
}
