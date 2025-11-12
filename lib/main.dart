import 'package:flutter/material.dart';
import 'package:vigilanter_flutter/screens/deskripsi_laporan_screen.dart';
import 'package:vigilanter_flutter/screens/setting_screen.dart';
import 'package:vigilanter_flutter/screens/signin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigilanter_flutter/screens/splash.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(), // semua text pakai Poppins
      ),
      home: SettingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


