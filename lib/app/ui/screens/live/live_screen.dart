import 'package:double_tap/app/ui/screens/live/play/play_section.dart';
import 'package:double_tap/app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveScreen extends ConsumerStatefulWidget {
  const LiveScreen({super.key});

  @override
  ConsumerState<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends ConsumerState<LiveScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPrimary(
      appBarText: 'Live',
      body: WidgetBody(
        children: [
          PlaySection(),
        ],
      ),
    );
  }
}
