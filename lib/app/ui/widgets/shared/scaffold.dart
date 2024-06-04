import 'package:flutter/material.dart';

import '../../ui.dart';

class ScaffoldPrimary extends StatelessWidget {
  const ScaffoldPrimary({
    super.key,
    required this.body,
    required this.appBarText,
  });

  final Widget body;
  final String appBarText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //quedamos
        title: Text(
          appBarText,
          style: textTitle,
        ),
      ),
      body: body,
    );
  }
}
