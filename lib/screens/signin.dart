import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool isChecked = false; // simpan state checkbox di sini

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF000229),
      resizeToAvoidBottomInset: false, // biar UI tidak naik saat keyboard muncul
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 600;
          screenWidth = constraints.maxWidth;

          return Center(
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.07),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Judul
                  Container(
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

                  // Form Input Email
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: const Color(0xFF787A95),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF1b1e3f),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          screenWidth * 0.1,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.055,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: const Color(0xFF787A95),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: screenHeight * 0.025),

                  // Form input password
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: const Color(0xFF787A95),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF1b1e3f),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          screenWidth * 0.1,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.04),
                        child: Icon(
                          Icons.visibility_off_rounded,
                          color: const Color(0xFF585a74),
                          size: screenWidth * 0.06,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.055,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: const Color(0xFF787A95),
                    ),
                    obscureText: true,
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Checkbox + lupa password
                  Container(
                    padding: EdgeInsets.only(
                      right: screenWidth * 0.011,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Kiri: Checkbox + Text
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
                              style: const TextStyle(
                                color: Color(0xFF787A95) , // 0xFF585a74
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        // Kanan: Lupa Kata Sandi
                        const Text(
                          "Lupa Kata Sandi?",
                          style: TextStyle(
                            color: Color(0xFFfee600),
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFFfee600),
                            decorationThickness: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Tombol Login
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.053,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFfee600),
                        foregroundColor: const Color(0xFF000229),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.1,
                          ),
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
          );
        },
      ),

      // Bottom text
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.03),
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
                color: const Color(0xFFfee600),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.038,
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xFFfee600),
                decorationThickness: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
