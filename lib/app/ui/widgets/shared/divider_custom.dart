import 'package:flutter/material.dart';

import '../../ui.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({super.key, this.ident});

  final double? ident;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Divider(
        color: dividerGrey,
        thickness: 1.5,
        indent: ident ?? 12,
        height: 0,
      ),
    );
  }
}
