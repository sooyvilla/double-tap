import 'package:animate_do/animate_do.dart';
import 'package:double_tap/app/domain/entities/store.dart';
import 'package:double_tap/app/ui/extensions/color_raimbow.dart';
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
            if (live.storeUser?.nightMarket != null &&
                live.storeUser!.nightMarket!.isNotEmpty)
              _ItemsStoreWidget(live: live, isNightMarket: true),
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
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.23,
      margin: const EdgeInsets.all(4),
      child: CarouselView(
        itemSnapping: true,
        onTap: (index) {
          final item = live.storeUser!.packs![index];
          showModal(
            context,
            _ItemsStoreWidget(
              live: null,
              packsWeapon: item.weapons,
            ),
          );
        },
        itemExtent: size.width * 0.85,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        backgroundColor: Colors.transparent,
        children: List.generate(
          live.storeUser?.packs?.length ?? 0,
          (index) {
            final item = live.storeUser!.packs![0];

            return Container(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item.displayIcon,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const GradientWidget(
                    roundedTopCorners: true,
                  ),
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
                              text: item.price.formatNumber(),
                              style: textNormal,
                            ),
                          ],
                        ),
                        SlideCountdown(
                          style: subTitleGrey,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          duration: Duration(seconds: item.timePack),
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
                      text: item.name,
                      style: textTitle,
                      right: 0,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ItemsStoreWidget extends StatefulWidget {
  const _ItemsStoreWidget({
    required this.live,
    this.packsWeapon,
    this.isNightMarket = false,
  });

  final LiveState? live;
  final bool isNightMarket;
  final List<WeaponSingle?>? packsWeapon;

  @override
  State<_ItemsStoreWidget> createState() => _ItemsStoreWidgetState();
}

class _ItemsStoreWidgetState extends State<_ItemsStoreWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<WeaponSingle?>? weapons;

  @override
  void initState() {
    super.initState();
    _setItems();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(
        reverse: true,
      );
  }

  void _setItems() {
    if (widget.isNightMarket) {
      weapons = widget.live!.storeUser!.nightMarket;
    } else if (widget.packsWeapon != null) {
      weapons = widget.packsWeapon;
    } else {
      weapons = widget.live!.storeUser!.store;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: widget.packsWeapon != null && weapons!.length > 3
          ? height * 0.9
          : null,
      child: SingleChildScrollView(
        physics: widget.packsWeapon != null
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isNightMarket && widget.packsWeapon != null)
              TextWithPadding(
                text: 'Night Market',
                style: textTitle.copyWith(fontSize: 30),
              ).withAnimatedRainbowEffect(
                animation: _controller,
              ),
            ListView.builder(
              itemCount: weapons!.length,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final item = weapons![index]!;
                return GestureDetector(
                  onTap: () {
                    if (item.displayVideo == null) return;
                    showModal(
                      context,
                      VideoPlayerWidget(
                        url: item.displayVideo!,
                        text: item.name,
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
                          if (widget.isNightMarket)
                            TextWithPadding(
                              text:
                                  '${item.price.formatNumber()} - ${item.discount}%',
                              style: textNormal.copyWith(color: Colors.red),
                            ),
                          Image.asset(
                            'assets/valorant/wallet/vp-modified.png',
                            width: 25,
                            color: Colors.white,
                          ),
                          TextWithPadding(
                            text: item.price.formatNumber(
                              discountPercentage:
                                  widget.isNightMarket ? item.discount : null,
                            ),
                            left: widget.isNightMarket ? 12 : 12,
                            style: textNormal,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Image.network(
                          item.displayIcon ?? '',
                          width: double.infinity,
                          height: 70,
                        ),
                      ),
                      TextWithPadding(
                        text: item.name,
                        style: textTitle,
                        textAlign: TextAlign.right,
                      ),
                      if (index != weapons!.length - 1) const DividerCustom()
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
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
                    color: Colors.white,
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
                    color: Colors.white,
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
              duration: Duration(seconds: live.storeUser!.timeStore),
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
