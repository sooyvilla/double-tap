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

    if (live.loading) {
      return const CircularLoad();
    }

    return ContainerGreyColumn(
      titleSection: 'Store',
      children: [
        _WalletWidget(live: live),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: live.storeUser!.featuredBundle!.bundles!.length,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final item = live.storeUser!.featuredBundle!.bundles![index];
              return Container(
                padding: const EdgeInsets.all(8),
                child: Image.network(
                  'https://media.valorant-api.com/bundles/${item.dataAssetId}/displayicon.png',
                ),
              );
            },
          ),
        ),
        _ItemsStoreWidget(live: live),
      ],
    );
  }
}

class _ItemsStoreWidget extends StatelessWidget {
  const _ItemsStoreWidget({
    required this.live,
  });

  final LiveState live;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: live.storeUser!.infoItemStores!.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final item = live.storeUser!.infoItemStores![index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/valorant/wallet/vp-modified.png',
                  width: 25,
                ),
                TextWithPadding(
                  text: live.storeUser!.skinsPanelLayout!
                      .singleItemStoreOffers![index].cost!.cost!
                      .formatNumber(),
                  style: textNormal,
                ),
              ],
            ),
            Image.network(
              item.data!.displayIcon!,
              width: double.infinity,
              height: 80,
            ),
            TextWithPadding(
              text: item.data!.displayName!,
              style: textTitle,
            ),
            if (index != live.storeUser!.infoItemStores!.length - 1)
              const DividerCustom(
                ident: 0,
              )
          ],
        );
      },
    );
  }
}

class _WalletWidget extends ConsumerWidget {
  const _WalletWidget({
    required this.live,
  });

  final LiveState live;

  @override
  Widget build(BuildContext context, ref) {
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
          TextWithPadding(
            text: live.wallet!.money!.formatNumber(),
            style: textNormal.copyWith(
                color: live.wallet!.money == 10000 ? Colors.pink : null),
          ),
          IconButton(
            color: primaryRed,
            onPressed: () async {
              await ref.read(liveProvider.notifier).init();
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
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

