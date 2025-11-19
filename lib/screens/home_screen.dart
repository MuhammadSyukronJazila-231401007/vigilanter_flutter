import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vigilanter_flutter/config/router.dart';
import 'package:vigilanter_flutter/services/dialog_service.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.biruVigilanter,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.03),

                // ===== Card User Info =====
                Card(
                  color: AppColors.biruGelap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.035),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ===== Avatar + Settings (ditumpuk) =====
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Avatar user
                            Container(
                              width: screenWidth * 0.115,
                              height: screenWidth * 0.115,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: screenWidth * 0.095,
                                ),
                              ),
                            ),

                            // ===== Ikon Settings (floating di kiri bawah avatar) =====
                            Positioned(
                              bottom: -screenWidth * 0.010,
                              left: -screenWidth * 0.010,
                              child: GestureDetector(
                                onTap: () {
                                  context.push(AppRoutes.setting);
                                },
                                child: Container(
                                  width: screenWidth * 0.050,
                                  height: screenWidth * 0.050,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.biruGelap,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.settings_rounded,
                                    size: screenWidth * 0.030,
                                    color: AppColors.biruGelap,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: screenWidth * 0.035),

                        // ===== User info =====
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.005),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Muhammad Dzakwan",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: screenWidth * 0.035,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.01),

                                    // Logout
                                    GestureDetector(
                                      onTap: () {
                                        // TODO: Handle logout
                                      },
                                      child: Icon(
                                        Icons.logout_rounded,
                                        color: Colors.white.withOpacity(0.9),
                                        size: screenWidth * 0.06,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: screenHeight * 0.004),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_rounded,
                                      color: Colors.white,
                                      size: screenWidth * 0.05,
                                    ),
                                    SizedBox(width: screenWidth * 0.01),
                                    Flexible(
                                      child: Text(
                                        "Simpang Tiga Kampus USU",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w300,
                                          fontSize: screenWidth * 0.033,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ===== Notification tetap di kanan =====
                        GestureDetector(
                          onTap: () {
                            // TODO: Handle notification
                          },
                          child: Icon(
                            Icons.notifications_rounded,
                            color: Colors.white,
                            size: screenWidth * 0.075,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                // ===== Greetings =====
                Column(
                  children: [
                    Text(
                      "Halo Muhammad Dzakwan,",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "Butuh Laporan/Panggilan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: screenWidth * 0.065,
                      ),
                    ),
                    Text(
                      "Darurat?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: screenWidth * 0.065,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Silahkan tekan tombol berikut!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.05),

                // ===== Buttons =====
                GestureDetector(
                  onTap: () {
                    // TODO: Handle Lapor
                  },
                  child: Image.asset(
                    "assets/images/tombol_lapor.png",
                    width: screenWidth * 0.6,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    splashColor: Colors.white.withOpacity(0.3),
                    onTap: () {
                      DialogService.showEmergencyPopup(context);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/tombol_panggil.png",
                        width: screenWidth * 0.6,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
