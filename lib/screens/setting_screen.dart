import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool notification = false;
  bool location = false;
  bool camera = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.biruVigilanter,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),

              // ===== HEADER =====
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: screenWidth * 0.085,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.085), // agar teks benar-benar center
                ],
              ),
              SizedBox(height: screenHeight * 0.03),

              // ===== PROFILE SECTION =====
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar user
                  Container(
                    width: screenWidth * 0.12,
                    height: screenWidth * 0.12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: screenWidth * 0.1,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),

                  // Info user
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jonto Amgis', // TODO: variable user name
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'jontoAmgis@gmail.com', // TODO: variable email
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: screenWidth * 0.035,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Tombol edit
                  IconButton(
                    onPressed: () {}, // TODO: Edit profile
                    icon: Icon(
                      Icons.mode_edit_outline_rounded,
                      color: Colors.white,
                      size: screenWidth * 0.07,
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.02),
              Divider(
                color: Colors.white.withOpacity(0.25),
                thickness: 1.5,
                indent: screenWidth * 0.02,
                endIndent: screenWidth * 0.02,
              ),
              SizedBox(height: screenHeight * 0.03),

              // ===== SETTINGS TOGGLES =====
              _buildSettingItem(
                context,
                icon: Icons.notifications_active_outlined,
                title: 'Notifications',
                description: 'Mengizinkan aplikasi mengirim notifikasi',
                value: notification,
                onChanged: (v) => setState(() => notification = v),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildSettingItem(
                context,
                icon: Icons.location_on_outlined,
                title: 'Location',
                description: 'Mengizinkan aplikasi mengakses lokasi anda',
                value: location,
                onChanged: (v) => setState(() => location = v),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildSettingItem(
                context,
                icon: Icons.camera_alt_outlined,
                title: 'Camera',
                description: 'Mengizinkan aplikasi mengakses kamera anda',
                value: camera,
                onChanged: (v) => setState(() => camera = v),
              ),

              SizedBox(height: screenHeight * 0.03),
              Divider(
                color: Colors.white.withOpacity(0.25),
                thickness: 1.5,
                indent: screenWidth * 0.02,
                endIndent: screenWidth * 0.02,
              ),
              SizedBox(height: screenHeight * 0.02),

              // ===== LOGOUT =====
              Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                    size: screenWidth * 0.075,
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: screenWidth * 0.075,
        ),
        SizedBox(width: screenWidth * 0.035),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.04,
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: screenWidth * 0.03,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          inactiveThumbColor: Colors.white,
          activeTrackColor: Colors.transparent,
          inactiveTrackColor: Colors.transparent,
          trackOutlineColor:
              WidgetStateProperty.resolveWith((_) => Colors.white),
          trackOutlineWidth: WidgetStateProperty.all(3.5),
        ),
      ],
    );
  }
}
