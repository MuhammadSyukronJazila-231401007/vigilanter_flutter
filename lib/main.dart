import 'package:flutter/material.dart';
import 'package:vigilanter_flutter/config/router.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createRouter();

    return MaterialApp.router(
      title: 'Vigilanter',
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }

}


