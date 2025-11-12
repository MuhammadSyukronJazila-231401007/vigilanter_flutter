import 'package:flutter/material.dart';
import 'package:vigilanter_flutter/screens/splash.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const Splash(),
      debugShowCheckedModeBanner: false,
    );
  }

}


