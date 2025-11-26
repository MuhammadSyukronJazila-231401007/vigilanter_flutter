import 'package:flutter/material.dart';
import 'package:vigilanter_flutter/theme/app_colors.dart';
import 'signin.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isChecked = false;
  final List<String> jenisKelaminList = ['Laki-laki', 'Perempuan'];
  String? selectedJenisKelamin;

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
          padding: EdgeInsets.all(screenWidth * 0.09),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul
              Text(
                "Buat Akun",
                style: TextStyle(
                  fontSize: screenWidth * (isLargeScreen ? 0.06 : 0.08),
                  color: Colors.white,
                  fontWeight: FontWeight.w800, // paling tebal
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Nama Depan
              _buildTextField(
                hint: 'Nama Depan',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              SizedBox(height: screenHeight * 0.025),

              // Nama Belakang
              _buildTextField(
                hint: 'Nama Belakang',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              SizedBox(height: screenHeight * 0.025),

              // Jenis Kelamin (Dropdown) — dibuat selebar form
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: AppColors.biruGelap,
                  borderRadius: BorderRadius.circular(21), // lebih kecil
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: AppColors.biruGelap,
                    value: selectedJenisKelamin,
                    hint: Text(
                      'Jenis Kelamin',
                      style: TextStyle(
                        color: AppColors.abuMuda,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.abuMuda,
                      size: screenWidth * 0.06,
                    ),
                    items: jenisKelaminList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: AppColors.abuMuda,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedJenisKelamin = newValue;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.025),

              // Tanggal Lahir
              _buildTextField(
                hint: 'Tanggal Lahir (hh/bb/tttt)',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                readOnly: true,
              ),

              SizedBox(height: screenHeight * 0.025),

              _buildTextField(
                hint: 'Nomor Induk Kependudukan (NIK)',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              SizedBox(height: screenHeight * 0.025),

              _buildTextField(
                hint: 'Nomor Telepon',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              SizedBox(height: screenHeight * 0.025),

              _buildTextField(
                hint: 'Email',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              SizedBox(height: screenHeight * 0.025),

              _buildTextField(
                hint: 'Kata Sandi Baru',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                obscureText: true,
              ),

              SizedBox(height: screenHeight * 0.025),

              _buildTextField(
                hint: 'Konfirmasi Kata Sandi Baru',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                obscureText: true,
              ),

              SizedBox(height: screenHeight * 0.03),

              // Checkbox + teks
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
                  Expanded(
                    child: Text(
                      "Saya menyetujui syarat & kebijakan privasi",
                      style: TextStyle(
                        color: AppColors.abuMuda,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.03),

              // Tombol Buat Akun (sesuai gaya tombol login)
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
                    'Buat Akun',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Sudah punya akun? Masuk
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah punya akun?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.037,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.015),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Signin(),
                        ),
                      );
                    },
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        color: AppColors.kuningVigilanter,
                        fontWeight: FontWeight.w900,
                        fontSize: screenWidth * 0.04,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.kuningVigilanter,
                        decorationThickness: 1.2,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  // Widget reusable untuk input field
  Widget _buildTextField({
    required String hint,
    required double screenWidth,
    required double screenHeight,
    bool obscureText = false,
    bool readOnly = false,
  }) {
    return TextField(
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: screenWidth * 0.04,
          color: AppColors.abuMuda,
        ),
        filled: true,
        fillColor: AppColors.biruGelap,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21), // tidak terlalu rounded
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.012,
          horizontal: screenWidth * 0.05,
        ),
      ),
      style: TextStyle(
        fontSize: screenWidth * 0.037,
        color: AppColors.abuMuda,
      ),
    );
  }
}
