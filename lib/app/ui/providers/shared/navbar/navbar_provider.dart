import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navbarStateNotifierProvider =
    StateNotifierProvider<NavbarNotifier, NavbarState>(
        (ref) => NavbarNotifier());

class NavbarNotifier extends StateNotifier<NavbarState> {
  NavbarNotifier() : super(const NavbarState());

  // quedamo
  final tabs = [
    const NavigationDestination(
      icon: Icon(Icons.access_time_filled),
      tooltip: 'Career',
      label: 'Career',
    ),
    const NavigationDestination(
      icon: Icon(Icons.play_arrow_rounded),
      tooltip: 'Live',
      label: 'Live',
    ),
    const NavigationDestination(
      icon: Icon(Icons.settings),
      tooltip: 'Settings',
      label: 'Settings',
    ),
  ];

  final navigatorKeys = [
    GlobalKey<NavigatorState>(debugLabel: 'Career tab'),
    GlobalKey<NavigatorState>(debugLabel: 'Live tab'),
    GlobalKey<NavigatorState>(debugLabel: 'Settings tab'),
  ];

  // todo: solucionar error al darle tab mas de una vez a cualquier seccion

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
