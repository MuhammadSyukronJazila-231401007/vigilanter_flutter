import 'package:flutter/material.dart';
import 'package:tugas_per2/screens/signin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_per2/screens/splash.dart';

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
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}


