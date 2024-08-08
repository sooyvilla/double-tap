import 'package:double_tap/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ui.dart';

final navbarStateNotifierProvider =
    StateNotifierProvider<NavbarNotifier, NavbarState>(
        (ref) => NavbarNotifier());

class NavbarNotifier extends StateNotifier<NavbarState> {
  NavbarNotifier() : super(const NavbarState());

  final tabs = [
    FloatingBottomNavItem(
      activeIcon: const Icon(
        CupertinoIcons.play_arrow_solid,
        size: 35,
      ),
      inactiveIcon: const Icon(
        CupertinoIcons.play_arrow_solid,
        size: 30,
      ),
      label: language.navBar.live,
    ),
    FloatingBottomNavItem(
      activeIcon: const Icon(
        CupertinoIcons.settings,
        size: 35,
      ),
      inactiveIcon: const Icon(
        CupertinoIcons.settings,
        size: 30,
      ),
      label: language.navBar.settings,
    ),
  ];

  final navigatorKeys = [
    GlobalKey<NavigatorState>(debugLabel: 'Live tab'),
    GlobalKey<NavigatorState>(debugLabel: 'Settings tab'),
  ];

  NavigatorState get currentNavigator =>
      navigatorKeys[state.currentTab].currentState!;

  void onTabSelected(int tab) {
    if (tab == state.currentTab && currentNavigator.canPop()) {
      currentNavigator.popUntil((route) => route.isFirst);
    } else {
      state = state.copyWith(currentTab: tab);
    }
  }

  bool canPop() {
    return currentNavigator.canPop();
  }
}

class NavbarState {
  const NavbarState({this.index = 0, this.currentTab = 0});
  final int index;
  final int currentTab;

  NavbarState copyWith({
    int? index,
    int? currentTab,
  }) {
    return NavbarState(
      index: index ?? this.index,
      currentTab: currentTab ?? this.currentTab,
    );
  }
}
