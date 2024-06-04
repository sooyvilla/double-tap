import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insane_bolt/app/ui/ui.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: buttonWithoutBackground,
        ),
      ),
    );

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        backgroundColor: MaterialStateProperty.all<Color?>(Colors.transparent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        alignment: Alignment.centerRight,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          textAlign: TextAlign.left,
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
  });

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color?>(primaryRed),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 20.0),
        ),
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: buttonWithBackground,
      ),
    );
  }
}
