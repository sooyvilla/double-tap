import 'package:flutter/material.dart';

import '../../ui.dart';

class ContainerGreyColumn extends StatelessWidget {
  const ContainerGreyColumn({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.titleSection,
  });

  final List<Widget> children;
  final String titleSection;
  final CrossAxisAlignment crossAxisAlignment;

  List<Widget> _buildChildrenWithDividers() {
    List<Widget> childrenWithDividers = [];

    for (int i = 0; i < children.length; i++) {
      childrenWithDividers.add(children[i]);
      // Agregar un Divider después de cada widget excepto el último
      if (i < children.length - 1) {
        childrenWithDividers.add(const DividerCustom());
      }
    }

    return childrenWithDividers;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              titleSection,
              textAlign: TextAlign.left,
              style: subTitleGrey,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: primaryGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            children: _buildChildrenWithDividers(),
          ),
        ),
      ],
    );
  }
}
