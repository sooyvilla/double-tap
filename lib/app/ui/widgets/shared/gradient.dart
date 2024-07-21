import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: MediaQuery.of(context).size.height /
              2, // Ajusta esto según el tamaño de la imagen
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black87,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
