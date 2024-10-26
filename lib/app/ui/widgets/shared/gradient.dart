import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  final bool roundedTopCorners;

  const GradientWidget({super.key, this.roundedTopCorners = false});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black87,
                Colors.transparent,
              ],
            ),
            borderRadius: roundedTopCorners
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
