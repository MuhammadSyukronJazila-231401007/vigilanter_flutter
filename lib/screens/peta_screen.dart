import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PetaScreen extends StatelessWidget {
  const PetaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.biruVigilanter,
      body: const Center(
        child: Text(
          "Halaman Peta",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
