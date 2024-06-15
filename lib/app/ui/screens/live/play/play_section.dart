import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import '../../../ui.dart';

class PlaySection extends ConsumerWidget {
  const PlaySection({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(accountProvider);
    return ContainerGreyColumn(
      titleSection: 'Play',
      children: [
        if (user.isLoggedIn)
          Row(
            children: [
              const Expanded(
                child: TextWithPadding(
                  text: 'Ranked',
                  style: textNormal,
                ),
              ),
              const Spacer(),
              Expanded(
                child: ButtonPrimary(
                  ceroPadding: true,
                  text: 'Change mode',
                  onPressed: () {},
                ),
              )
            ],
          ),
        if (user.isLoggedIn)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    user.user!.card!.small!,
                    width: 50,
                  ),
                ),
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
                const Spacer(),
                Switch(
                  value: user.partyPlayer!.members[0].isReady,
                  activeColor: Colors.white,
                  activeTrackColor: Colors.greenAccent[400],
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  trackOutlineColor:
                      MaterialStateProperty.all(Colors.transparent),
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        if (user.isLoggedIn)
          Padding(
            padding: const EdgeInsets.all(8.12),
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: ButtonCustomBackground(
                    text: 'Find match',
                    invertColors: true,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.refresh_rounded,
                      color: primaryRed,
                    ),
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
