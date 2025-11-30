import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:provider/provider.dart';
import 'package:vigilanter_flutter/config/router.dart';
import 'package:vigilanter_flutter/provider/app_state_provider.dart';
import 'package:vigilanter_flutter/provider/auth_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import './provider/laporan_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load app state
  final appStateProvider = AppStateProvider();
  await appStateProvider.loadPreferences();

  // Init Firebase
  await Firebase.initializeApp();

  // 🔥 Tambahkan ini (request izin sebelum runApp)
  await _setupPermissionsAndMediaStore();

  // Inisialisasi Format tanggal
  await initializeDateFormatting('id_ID', null);

  runApp(const App());
}

/// Fungsi untuk meminta izin & initialize MediaStore
Future<void> _setupPermissionsAndMediaStore() async {
  if (!Platform.isAndroid) return;

  List<Permission> permissions = [Permission.storage];

  final sdk = await MediaStore().getPlatformSDKInt();
  if (sdk >= 33) {
    permissions.addAll([
      Permission.photos,
      Permission.videos,
      Permission.audio,
    ]);
  }

  await permissions.request();

  await MediaStore.ensureInitialized();
  MediaStore.appFolder = "Vigilanter"; // optional
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
        ChangeNotifierProvider(create: (_) => LaporanProvider()),
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
