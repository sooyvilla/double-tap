import 'package:animate_do/animate_do.dart';
import 'package:double_tap/app/ui/screens/live/store/video_player.dart';
import 'package:double_tap/app/ui/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../providers/providers.dart';
import '../../../ui.dart';

class StoreSection extends ConsumerWidget {
  const StoreSection({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final live = ref.watch(liveProvider);
    final settings = ref.watch(settingsProvider);

    return ContainerGreyColumn(
      titleSection: 'Store',
      children: [
        if (live.loading || settings.isLoading) const CircularLoad(),
        if (!settings.isLoggedIn &&
            live.storeUser == null &&
            !live.loading &&
            !settings.isLoading)
          const Column(
            children: [
              Icon(Icons.storefront_rounded, size: 80),
              TextWithPadding(
                text: 'No store found',
                style: textTitle,
              ),
            ],
          ),
        if (live.storeUser != null && !live.loading && !settings.isLoading) ...[
          _WalletWidget(live: live),
          _PacksStoreWidget(live: live),
          _ItemsStoreWidget(live: live),
        ],
      ],
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
          return Container(
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
                        duration:
                            Duration(seconds: item.durationRemainingInSeconds!),
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
                    text:
                        live.storeUser!.bundleInfos![index].data!.displayName!,
                    style: textTitle,
                    right: 0,
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
          onTap: item.data!.streamedVideo == null
              ? null
              : () {
                  showModal(
                    context,
                    VideoPlayerWidget(
                      url: item.data!.streamedVideo!,
                      text: item.data!.displayName!,
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
                  item.data!.displayIcon!,
                  width: double.infinity,
                  height: 70,
                ),
              ),
              TextWithPadding(
                text: item.data!.displayName!,
                style: textTitle,
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
                infinite: live.loading,
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
            const TextWithPadding(
              text: 'Refresh:',
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
