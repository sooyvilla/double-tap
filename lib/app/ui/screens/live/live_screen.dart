import 'package:double_tap/app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'store/store_section.dart';
import 'user/user_section.dart';

class LiveScreen extends ConsumerWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ScaffoldPrimary(
      appBarText: 'Live',
      body: WidgetBody(
        children: [
          PlaySection(),
          StoreSection(),
          // InventorySection(),
        ],
      ),
    );
  }
}
