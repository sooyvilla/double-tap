import 'package:flutter/material.dart';

class TextWithPadding extends StatelessWidget {
  const TextWithPadding({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.top = 12,
    this.bottom = 12,
    this.left = 12,
    this.right = 12,
  });

  final String text;
  final TextStyle? style;
  final double top;
  final double bottom;
  final double left;
  final double right;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}
