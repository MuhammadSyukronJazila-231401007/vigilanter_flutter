import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool isChecked = false;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.biruVigilanter,
      resizeToAvoidBottomInset: false,

      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.07),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Masuk",
                  style: TextStyle(
                    fontSize: screenWidth * (isLargeScreen ? 0.06 : 0.08),
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Input Email
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: AppColors.abuMuda,
                  ),
                  filled: true,
                  fillColor: AppColors.biruGelap,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.1),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.012,
                    horizontal: screenWidth * 0.055,
                  ),
                ),
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: AppColors.abuMuda,
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: screenHeight * 0.025),

              // Input Password
              TextField(
                obscureText: _isObscure,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: AppColors.abuMuda,
                  ),
                  filled: true,
                  fillColor: AppColors.biruGelap,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.1),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.012,
                    horizontal: screenWidth * 0.055,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: AppColors.abuTua,
                      size: screenWidth * 0.06,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: AppColors.abuMuda,
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        visualDensity: const VisualDensity(horizontal: -4),
                      ),
                      Text(
                        "Ingat Saya!",
                        style: TextStyle(
                          color: AppColors.abuMuda,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Lupa Kata Sandi?",
                    style: TextStyle(
                      color: AppColors.kuningVigilanter,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.kuningVigilanter,
                      decorationThickness: 1.2,
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.03),

              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.053,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kuningVigilanter,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.1),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Belum Punya Akun? ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Buat akun baru",
              style: TextStyle(
                color: AppColors.kuningVigilanter,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.038,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.kuningVigilanter,
                decorationThickness: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
