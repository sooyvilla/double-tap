import 'package:animate_do/animate_do.dart';
import 'package:double_tap/app/domain/entities/store.dart';
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
            _StoreTab(live: live),
          ],
        ],
      ),
    );
  }
}

class _StoreTab extends StatefulWidget {
  const _StoreTab({required this.live});

  final LiveState live;

  @override
  State<_StoreTab> createState() => __StoreTabState();
}

class __StoreTabState extends State<_StoreTab> with TickerProviderStateMixin {
  late LiveState live;
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    live = widget.live;
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();

    // Sync tabController with pageController
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          controller: _tabController,
          tabs: [
            Tab(text: language.live.storeSection.title),
            const Tab(text: 'Night Market'),
          ],
        ),
        SizedBox(
          height: _tabController.index == 0 ? height * 0.79 : height * 1.17,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              _tabController.animateTo(index);
              setState(() {});
            },
            children: [
              _ItemsStoreWidget(live: live),
              _ItemsStoreWidget(live: live, isNightMarket: true),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
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
        itemCount: live.storeUser?.packs?.length ?? 0,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          final item = live.storeUser!.packs![index];

          return GestureDetector(
            onTap: () {
              showModal(
                context,
                _ShowItemsBundle(weapons: item.weapons, live: live),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  Image.network(
                    item.displayIcon,
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

  final List<WeaponSingle?>? weapons;
  final LiveState live;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.85;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWithPadding(
            text: language.live.storeSection.titleModal,
            style: textTitle,
          ),
          SizedBox(
            height: weapons!.length > 5 ? height : null,
            child: ListView.builder(
              itemCount: weapons!.length,
              physics: weapons!.length > 4
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final item = weapons![index];
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Image.network(
                          item?.displayIcon! ?? '',
                          width: double.infinity,
                          height: 70,
                        ),
                      ),
                      TextWithPadding(
                        text: item!.name,
                        style: textTitle,
                        textAlign: TextAlign.right,
                      ),
                      if (index != weapons!.length - 1) const DividerCustom(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemsStoreWidget extends StatelessWidget {
  const _ItemsStoreWidget({
    required this.live,
    this.isNightMarket = false,
  });

  final LiveState live;
  final bool isNightMarket;

  @override
  Widget build(BuildContext context) {
    final weapons =
        isNightMarket ? live.storeUser!.nightMarket : live.storeUser!.store;

    return ListView.builder(
      itemCount: weapons!.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final item = weapons[index];
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
                  Image.asset(
                    'assets/valorant/wallet/vp-modified.png',
                    width: 25,
                  ),
                  TextWithPadding(
                    text: item.price.formatNumber(),
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
              if (index != weapons.length - 1) const DividerCustom()
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
