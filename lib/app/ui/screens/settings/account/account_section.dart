import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import '../../../ui.dart';
import '../../../util/util.dart';
import 'login_form.dart';

class AccountSection extends ConsumerStatefulWidget {
  const AccountSection({super.key});

  @override
  ConsumerState<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends ConsumerState<AccountSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(accountProvider.notifier).validateSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(accountProvider);
    return ContainerGreyColumn(
      titleSection: 'Accounts',
      crossAxisAlignment: CrossAxisAlignment.start,
      children: user.isLoading
          ? [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ]
          : [
              if (!user.isLoggedIn)
                const TextWithPadding(text: 'Not signed in yet'),
              if (user.isLoggedIn)
                Row(
                  children: [
                    TextWithPadding(
                      text: user.username!,
                      right: 0,
                      style: textNormal,
                    ),
                    TextWithPadding(
                      text: ' #${user.tagLine}',
                      left: 0,
                      style: textNormalGrey,
                    ),
                  ],
                ),
              ButtonPrimary(
                text: user.isLoggedIn ? 'Logout' : 'Login',
                onPressed: () {
                  user.isLoggedIn
                      ? ref.read(accountProvider.notifier).logout()
                      : showModal(context, const LoginForm());
                  // ValorantApiMatchHistoryDatasource().getMatchHistory();
                },
              ),
            ],
    );
  }
}
