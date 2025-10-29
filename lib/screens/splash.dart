import 'dart:async';
import 'package:flutter/material.dart';
import 'signin.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // Splash tampil 3 detik, lalu ke Signin
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Signin()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF000229),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.07),
          child: Image.asset(
            'assets/images/vigilanter.png',
            width: screenWidth * 0.43,
            height: screenWidth * 0.43,
            fit: BoxFit.cover,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/vgt_txt.png',
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
              fit: BoxFit.contain,
            ),
            Transform.translate(
              offset: const Offset(0, -4), // biar text lebih nempel
              child: const Text(
                "Vigilance in your hand",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
