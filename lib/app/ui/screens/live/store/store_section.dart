import 'package:animate_do/animate_do.dart';
import 'package:double_tap/app/data/models/weapons.dart';
import 'package:double_tap/app/ui/screens/live/store/video_player.dart';
import 'package:double_tap/app/ui/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../../main.dart';
import '../../../providers/providers.dart';
import '../../../ui.dart';

class StoreSection extends ConsumerWidget {
  const StoreSection({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final live = ref.watch(liveProvider);
    final settings = ref.watch(settingsAccountProvider);
    final height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.15),
      child: ContainerGreyColumn(
        titleSection: language.live.storeSection.title,
        children: [
          if (live.isLoading || settings.isLoading) const CircularLoad(),
          if (!settings.isLoggedIn && !live.isLoading && !settings.isLoading)
            Column(
              children: [
                const Icon(Icons.storefront_rounded, size: 80),
                TextWithPadding(
                  text: language.live.storeSection.noDataStore,
                  style: textTitle,
                ),
              ],
            ),
          if (live.storeUser != null &&
              !live.isLoading &&
              !settings.isLoading &&
              settings.isLoggedIn) ...[
            _WalletWidget(live: live),
            _PacksStoreWidget(live: live),
            _ItemsStoreWidget(live: live),
          ],
        ],
      ),
    );
  }
}

class _PacksStoreWidget extends StatelessWidget {
  const _PacksStoreWidget({
    required this.live,
  });

  final LiveState live;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: live.storeUser!.featuredBundle!.bundles!.length,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          final item = live.storeUser!.featuredBundle!.bundles![index];
          final weapons = live.storeUser!.bundleItems;
          return GestureDetector(
            onTap: () {
              showModal(
                context,
                _ShowItemsBundle(weapons: weapons, live: live),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  Image.network(
                    'https://media.valorant-api.com/bundles/${item.dataAssetId}/displayicon.png',
                  ),
                  const GradientWidget(),
                  Positioned(
                    left: 12,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/valorant/wallet/vp-modified.png',
                              width: 25,
                              color: Colors.white,
                            ),
                            TextWithPadding(
                              text: live.storeUser!.featuredBundle!
                                  .bundles![index].totalDiscountedCost!.cost!
                                  .formatNumber(),
                              style: textNormal,
                            ),
                          ],
                        ),
                        SlideCountdown(
                          style: subTitleGrey,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          duration: Duration(
                              seconds: item.durationRemainingInSeconds!),
                          padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
                          separatorStyle: subTitleGrey,
                          separatorPadding: const EdgeInsets.all(0),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 12,
                    child: TextWithPadding(
                      text: live
                          .storeUser!.bundleInfos![index].data!.displayName!,
                      style: textTitle,
                      right: 0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ShowItemsBundle extends StatelessWidget {
  const _ShowItemsBundle({
    required this.weapons,
    required this.live,
  });

  final List<Weapon>? weapons;
  final LiveState live;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextWithPadding(
          text: language.live.storeSection.titleModal,
          style: textTitle,
        ),
        ListView.builder(
          itemCount: weapons!.length,
          physics: weapons!.length > 4
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            final item = weapons![index];
            return GestureDetector(
              onTap: () {
                if (item.levels!.last.streamedVideo == null) return;

                showModal(
                  context,
                  VideoPlayerWidget(
                    url: item.levels!.last.streamedVideo!,
                    text: item.displayName!,
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Image.network(
                      item.displayIcon!,
                      width: double.infinity,
                      height: 70,
                    ),
                  ),
                  TextWithPadding(
                    text: item.displayName!,
                    style: textTitle,
                    textAlign: TextAlign.right,
                  ),
                  if (index != live.storeUser!.infoItemStores!.length - 1)
                    const DividerCustom()
                ],
              ),
            );
          },
        ),
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
        return GestureDetector(
          onTap: item.levels!.last.streamedVideo == null
              ? null
              : () {
                  showModal(
                    context,
                    VideoPlayerWidget(
                      url: item.levels!.last.streamedVideo!,
                      text: item.displayName!,
                    ),
                  );
                },
          child: Column(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.network(
                  item.displayIcon ?? item.levels!.last.displayIcon!,
                  width: double.infinity,
                  height: 70,
                ),
              ),
              TextWithPadding(
                text: item.displayName!,
                style: textTitle,
                textAlign: TextAlign.right,
              ),
              if (index != live.storeUser!.infoItemStores!.length - 1)
                const DividerCustom()
            ],
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            if (live.wallet != null) ...[
              SpinPerfect(
                infinite: live.isLoading,
                child: IconButton(
                  color: primaryRed,
                  onPressed: () async {
                    await ref.read(liveProvider.notifier).init();
                  },
                  icon: const Icon(Icons.refresh_rounded),
                ),
              ),
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
              Row(
                children: [
                  Image.asset(
                    'assets/valorant/wallet/kc.png',
                    width: 25,
                  ),
                  TextWithPadding(
                    text: live.wallet!.money!.formatNumber(),
                    left: 5,
                    style: textNormal.copyWith(
                        color:
                            live.wallet!.money == 10000 ? Colors.pink : null),
                  ),
                ],
              ),
            ]
          ],
        ),
        Row(
          children: [
            TextWithPadding(
              text: '${language.live.storeSection.refreshTitle}:',
              top: 5,
              style: textNormal,
            ),
            const Spacer(),
            SlideCountdown(
              style: subTitleGrey,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              duration: Duration(
                  seconds: live.storeUser!.skinsPanelLayout!
                      .singleItemOffersRemainingDurationInSeconds!),
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
              separatorStyle: subTitleGrey,
              separatorPadding: const EdgeInsets.all(0),
              onDone: () async {
                await ref.read(liveProvider.notifier).init();
              },
            ),
          ],
        )
      ],
    );
  }
}
