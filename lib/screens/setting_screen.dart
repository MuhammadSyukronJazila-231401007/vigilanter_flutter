import 'package:flutter/material.dart';

import '../widgets/app_scaffold.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}
class _SettingScreenState extends State<SettingScreen>{
  bool notification = false;
  bool location = false;
  bool camera = false;
  @override

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AppScaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.06),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.03),
            //Header
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: screenWidth * 0.1,
                  ),
                  onPressed: () {
                    //Navigator.pop(context);
                  },
                ),
                SizedBox(width: screenWidth * 0.17,),
                Text(
                  'Settings',
                      style: TextStyle(
                        fontSize: screenWidth * 0.075,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            //Profil
            Row(
              children: [
                Container(
                  width: screenWidth * 0.12,
                  height: screenHeight * 0.12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white

                  ),
                  child: Icon(//TODO: photo
                    Icons.person,
                    color: Colors.black,
                    size: screenWidth * 0.1,
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //TODO: var
                      'Jonto Amgis',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.038,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      //TODO: var
                      'jontoAmgis@gmail.com',
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.2),
                IconButton(
                    onPressed: (){},//TODO: Edit Profile
                    icon: Icon(
                      Icons.mode_edit_outlined,
                      color: Colors.white,
                      size: screenWidth * 0.09,
                    )
                )
              ],
            ),
            Divider(
              color: Color(0xFFFFFFFF).withValues(alpha: 0.2),
              height: 25,
              thickness: 2,
              indent: 16,
              endIndent: 16,
            ),
            SizedBox(height: screenHeight * 0.03,),
            //Setting
            Row(
              children: [
                Icon(
                    Icons.notification_important_outlined,
                    color: Colors.white,
                    size: screenWidth * 0.08,
                ),
                SizedBox(width: screenWidth * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notifications',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.038
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.54,
                      child: Text(
                        'Mengizinkan aplikasi mengirim notifikasi',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: screenWidth * 0.025,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.07),
                Switch(
                    value: notification,
                  inactiveTrackColor: Colors.transparent,
                  activeTrackColor: Colors.transparent,
                  onChanged: (newValue) {//TODO: Allow function
                    setState(() {
                      notification = newValue;
                    });
                  },
                    trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) { return Colors.white;}
                    ),
                  trackOutlineWidth: WidgetStateProperty.all<double?>(5.0),
                  )
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            //Lokasi
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: screenWidth * 0.08,
                ),
                SizedBox(width: screenWidth * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.038
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.54,
                      child: Text(
                        'Mengizinkan aplikasi mengakses lokasi anda',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: screenWidth * 0.027,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.07),
                Switch(
                  value: location,
                  inactiveTrackColor: Colors.transparent,
                  activeTrackColor: Colors.transparent,
                  onChanged: (newValue) {//TODO: Allow function
                    setState(() {
                      location = newValue;
                    });
                  },
                  trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                          (Set<WidgetState> states) { return Colors.white;}
                  ),
                  trackOutlineWidth: WidgetStateProperty.all<double?>(5.0),
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            //Kamera
            Row(
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: screenWidth * 0.08,
                ),
                SizedBox(width: screenWidth * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Camera',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.038
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.54,
                      child: Text(
                        'Mengizinkan aplikasi mengakses kamera anda',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: screenWidth * 0.025,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.07),
                Switch(
                  value: camera,
                  inactiveTrackColor: Colors.transparent,
                  activeTrackColor: Colors.transparent,
                  onChanged: (newValue) {//TODO: Allow function
                    setState(() {
                      camera = newValue;
                    });
                  },
                  trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                          (Set<WidgetState> states) { return Colors.white;}
                  ),
                  trackOutlineWidth: WidgetStateProperty.all<double?>(5.0),
                )
              ],
            ),
            Divider(
              color: Color(0xFFFFFFFF).withValues(alpha: 0.2),
              height: 60,
              thickness: 2,
              indent: 16,
              endIndent: 16,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: (){}, //TODO: Log Out
                  icon: Icon(
                      Icons.logout_outlined,
                    color: Colors.white,
                    size: screenWidth * 0.08,
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.038
                  ),
                )
              ],
            )


          ],
        ),
      ),
    );
  }



}
