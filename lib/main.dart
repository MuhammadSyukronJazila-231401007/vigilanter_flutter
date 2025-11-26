import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vigilanter_flutter/config/router.dart';
import 'package:vigilanter_flutter/provider/app_state_provider.dart';
import 'package:vigilanter_flutter/provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appStateProvider = AppStateProvider();
  await appStateProvider.loadPreferences();
  await Firebase.initializeApp();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createRouter();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp.router(
        title: 'Vigilanter',
        theme: ThemeData(
          fontFamily: 'Poppins',
          useMaterial3: true,
        ),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

}


