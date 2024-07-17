import 'package:flutter/material.dart';

class WidgetBody extends StatelessWidget {
  const WidgetBody({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  List<Widget> _setSpaceBetweenChildren() {
    final List<Widget> childrenWithDividers = [];

    for (int i = 0; i < children.length; i++) {
      childrenWithDividers.add(children[i]);
      // Agregar un Divider después de cada widget excepto el último
      if (i < children.length - 1) {
        childrenWithDividers.add(const SizedBox(height: 25));
      }
    }

    return childrenWithDividers;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _setSpaceBetweenChildren(),
      ),
    );
  }
}
