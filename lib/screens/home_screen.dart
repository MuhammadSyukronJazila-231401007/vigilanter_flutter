import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.biruVigilanter,
      body: const Center(
        child: Text(
          "Halaman Beranda",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
