import 'package:flutter/cupertino.dart';

import '../../ui.dart';

class ScaffoldPrimary extends StatefulWidget {
  const ScaffoldPrimary({
    super.key,
    required this.body,
    required this.appBarText,
  });

  final Widget body;
  final String appBarText;

  @override
  State<ScaffoldPrimary> createState() => _ScaffoldPrimaryState();
}

class _ScaffoldPrimaryState extends State<ScaffoldPrimary> {
  final ScrollController _scrollController = ScrollController();
  late ValueNotifier<double> _fontSizeNotifier;

  @override
  void initState() {
    super.initState();
    _fontSizeNotifier = ValueNotifier<double>(30.0);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    double fontSize = 30.0;
    if (_scrollController.hasClients) {
      final double offset = _scrollController.offset;
      fontSize = 30.0 - (offset / 9).clamp(0.0, 10.0);
    }
    _fontSizeNotifier.value = fontSize;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _fontSizeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: ValueListenableBuilder<double>(
              valueListenable: _fontSizeNotifier,
              builder: (context, fontSize, child) {
                return Text(
                  widget.appBarText,
                  style: textTitle.copyWith(fontSize: fontSize),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: widget.body,
          ),
        ],
      ),
    );
  }
}
