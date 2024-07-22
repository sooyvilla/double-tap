import 'package:double_tap/app/ui/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    super.key,
    required this.onPressed,
    required this.text,
    this.top = 12,
    this.bottom = 12,
    this.left = 12,
    this.right = 12,
    this.ceroPadding = false,
    this.textAlign = TextAlign.left,
  });

  final void Function()? onPressed;
  final String text;
  final double top;
  final double bottom;
  final double left;
  final double right;
  final bool ceroPadding;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: ceroPadding
          ? const EdgeInsets.all(0)
          : EdgeInsets.fromLTRB(left, top, right, bottom),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          textAlign: textAlign,
          style: buttonWithoutBackground,
        ),
      ),
    );
  }
}

class ButtonCustomBackground extends StatelessWidget {
  const ButtonCustomBackground({
    super.key,
    this.onPressed,
    required this.text,
    this.invertColors = false,
  });

  final void Function()? onPressed;
  final String text;
  final bool invertColors;

  @override
  Widget build(BuildContext context) {
    final firstColor = invertColors ? dividerGrey : primaryRed;
    final secondColor = invertColors ? primaryRed : Colors.white;
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color?>(firstColor),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 20.0),
        ),
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: buttonWithBackground.copyWith(color: secondColor),
      ),
    );
  }
}
