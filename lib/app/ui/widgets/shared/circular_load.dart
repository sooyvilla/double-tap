import 'package:flutter/material.dart';

class CircularLoad extends StatelessWidget {
  const CircularLoad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
