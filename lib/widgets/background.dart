import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF000229)),
      child: child,
    );
  }
}