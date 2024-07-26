import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../ui.dart';

class NavigationbarCustom extends ConsumerStatefulWidget {
  const NavigationbarCustom({super.key});

  static final List<Widget> _buildScreens = [
    const LiveScreen(),
    const SettingsScreen()
  ];

  @override
  ConsumerState<NavigationbarCustom> createState() =>
      _NavigationbarCustomState();
}

class _NavigationbarCustomState extends ConsumerState<NavigationbarCustom> {
  @override
  Widget build(BuildContext context) {
    final navbarNotifier = ref.watch(navbarStateNotifierProvider.notifier);
    final width = MediaQuery.of(context).size.width;

    return FloatingBottomNavBar(
      pages: NavigationbarCustom._buildScreens,
      items: navbarNotifier.tabs,
      initialPageIndex: 0,
      backgroundColor: primaryGrey,
      bottomPadding: 0,
      elevation: 0,
      radius: 12,
      width: width * 0.9,
      height: 69,
    );
  }
}

class FloatingBottomNavBar extends StatefulWidget {
  final List<Widget> pages;
  final int? initialPageIndex;
  final double? elevation;
  final double? radius;
  final double? height;
  final double? width;
  final double? bottomPadding;
  final Color? backgroundColor;
  final List<FloatingBottomNavItem> items;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;

  const FloatingBottomNavBar({
    super.key,
    required this.pages,
    this.initialPageIndex,
    this.elevation = 0,
    this.radius = 20,
    this.backgroundColor = Colors.blue,
    this.height = 65,
    this.width = 300,
    this.bottomPadding = 5,
    required this.items,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
  });

  @override
  State<FloatingBottomNavBar> createState() => _FloatingBottomNavBarState();
}

class _FloatingBottomNavBarState extends State<FloatingBottomNavBar> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    selectedIndex = widget.initialPageIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: widget.pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius!),
          color: widget.backgroundColor,
        ),
        padding: EdgeInsets.only(bottom: widget.bottomPadding!),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          fixedColor: Colors.white,
          elevation: widget.elevation,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          unselectedFontSize:
              widget.items.any((element) => element.label == null)
                  ? 0
                  : widget.unselectedLabelStyle?.fontSize ?? 14,
          selectedFontSize: widget.items.any((element) => element.label == null)
              ? 0
              : widget.selectedLabelStyle?.fontSize ?? 14,
          selectedLabelStyle: widget.selectedLabelStyle,
          unselectedLabelStyle: widget.unselectedLabelStyle,
          onTap: onItemTapped,
          items: widget.items
              .map((item) => BottomNavigationBarItem(
                  icon: item.inactiveIcon,
                  activeIcon: item.activeIcon,
                  label: item.label ?? ''))
              .toList(),
        ),
      ),
    );
  }
}

class FloatingBottomNavItem {
  final String? label;
  final Widget inactiveIcon;
  final Widget? activeIcon;

  const FloatingBottomNavItem({
    this.label,
    required this.inactiveIcon,
    this.activeIcon,
  });
}
