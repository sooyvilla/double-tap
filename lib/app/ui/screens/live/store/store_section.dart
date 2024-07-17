import 'package:double_tap/app/ui/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import '../../../ui.dart';

class StoreSection extends ConsumerWidget {
  const StoreSection({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final live = ref.watch(liveProvider);
    final settings = ref.watch(settingsProvider);

    ref.listen<SettingsState>(settingsProvider, (previous, next) {
      if (next != previous) {
        if (next.isLoggedIn) {
          ref.read(liveProvider.notifier).init();
        }
      }
    });

    if (!settings.isLoggedIn) {
      return const ContainerGreyColumn(
        titleSection: 'Store',
        children: [
          Column(
            children: [
              Icon(Icons.storefront_rounded, size: 80),
              // SizedBox(height: 10),
              TextWithPadding(
                text: 'No store found',
                style: textTitle,
              ),
            ],
          )
        ],
      );
    }

    return ContainerGreyColumn(
      titleSection: 'Store',
      children: live.isLoading
          ? [const CircularLoad()]
          : [
              _WalletWidget(live: live),
              // ListView.builder(
              //   itemCount: store!.featuredBundle!.bundles!.length,
              //   shrinkWrap: true,
              //   itemBuilder: (_, index) {
              //     return Image.network(
              //         'https://media.valorant-api.com/weapons/${store.featuredBundle!.bundles![index].items![0].item!.itemTypeId}/displayicon.png');
              //   },
              // ),
            ],
    );
  }
}

class _WalletWidget extends StatelessWidget {
  const _WalletWidget({
    required this.live,
  });

  final LiveState live;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (live.wallet != null) ...[
          const Spacer(),
          Row(
            children: [
              Image.asset(
                'assets/valorant/wallet/vp-modified.png',
                width: 25,
              ),
              TextWithPadding(
                text: live.wallet!.valorantPoints!.formatNumber(),
                style: textNormal,
                left: 5,
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(
                'assets/valorant/wallet/rp-modified.png',
                width: 25,
              ),
              TextWithPadding(
                text: live.wallet!.radianitePoints!.formatNumber(),
                style: textNormal,
                left: 5,
              ),
            ],
          ),
          // TextWithPadding(
          //   text: store.wallet!.money!.formatNumber(),
          //   style: textNormal.copyWith(
          //       color: store.wallet!.money == 10000 ? Colors.pink : null),
          // ),
        ]
      ],
    );
  }
}

//todo: url para los packs
//'https://media.valorant-api.com/bundles/${id}/displayicon.png'

//todo: url para armas de la tienda
//

//todo: url para los accessoriews
//

