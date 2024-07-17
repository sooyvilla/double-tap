import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../ui.dart';

class NavigationbarCustom extends ConsumerStatefulWidget {
  const NavigationbarCustom({super.key});

  static final List<Widget> _buildScreens = [
    const CareerScreen(),
    const LiveScreen(),
    const SettingsScreen()
  ];

  @override
  ConsumerState<NavigationbarCustom> createState() =>
      _NavigationbarCustomState();
}

class _NavigationbarCustomState extends ConsumerState<NavigationbarCustom> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     ref.watch(liveProvider);
  //     ref.watch(settingsProvider);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final navbarState = ref.watch(navbarStateNotifierProvider);
    final navbarNotifier = ref.watch(navbarStateNotifierProvider.notifier);

    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          backgroundColor: primaryGrey,
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return TextStyle(color: primaryRed, fontSize: 14);
            }
            return TextStyle(color: secondaryGrey, fontSize: 14);
          }),
          iconTheme: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return IconThemeData(color: primaryRed, size: 35);
            }
            return IconThemeData(color: secondaryGrey, size: 35);
          }),
        ),
        child: NavigationBar(
          selectedIndex: navbarState.currentTab,
          destinations: navbarNotifier.tabs,
          onDestinationSelected:
              ref.read(navbarStateNotifierProvider.notifier).onTabSelected,
          animationDuration: const Duration(milliseconds: 500),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      body: IndexedStack(
        index: navbarState.currentTab,
        children: NavigationbarCustom._buildScreens,
      ),
    );
  }
}
