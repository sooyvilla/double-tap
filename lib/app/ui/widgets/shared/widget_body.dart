
import 'package:flutter/material.dart';

class WidgetBody extends StatelessWidget {
  const WidgetBody({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}