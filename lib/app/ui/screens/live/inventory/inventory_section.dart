import 'package:flutter/material.dart';

import '../../../ui.dart';

class InventorySection extends StatelessWidget {
  const InventorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContainerGreyColumn(
      titleSection: 'Inventory',
      children: [
        TextWithPadding(
          text: 'Inventory',
          style: textTitle,
        ),
      ],
    );
  }
}
