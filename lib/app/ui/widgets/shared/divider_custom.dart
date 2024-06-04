import 'package:flutter/material.dart';

import '../../ui.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: dividerGrey,
      thickness: 1.5,
      indent: 12,
    );
  }
}