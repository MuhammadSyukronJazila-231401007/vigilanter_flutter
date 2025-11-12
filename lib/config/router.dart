import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/splash.dart';
import '../screens/signin.dart';
import '../screens/register.dart';
import '../screens/deskripsi_laporan_screen.dart';
import '../screens/riwayat_laporan_screen.dart';
import '../screens/setting_screen.dart';
import '../screens/home_screen.dart';
import '../screens/peta_screen.dart';
import '../widgets/main_shell.dart';

class AppRoutes {
  static const splash = '/';
  static const signin = '/signin';
  static const register = '/register';
  static const deskripsiLaporan = '/deskripsi_laporan';
  static const riwayatLaporan = '/riwayat_laporan';
  static const setting = '/setting';
  static const home = '/home';
  static const peta = '/peta';
}

GoRouter createRouter() {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const Splash(),
      ),
      GoRoute(
        path: AppRoutes.signin,
        builder: (context, state) => const Signin(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const Register(),
      ),

      // Shell dengan bottom nav
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.riwayatLaporan,
                builder: (context, state) => const RiwayatLaporan(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.peta,
                builder: (context, state) => const PetaScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
