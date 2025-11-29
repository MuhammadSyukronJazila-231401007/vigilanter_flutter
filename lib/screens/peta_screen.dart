import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class PetaScreen extends StatefulWidget {
  @override
  State<PetaScreen> createState() => _PetaPageState();
}


class _PetaPageState extends State<PetaScreen> {
  GoogleMapController? mapController;
  TextEditingController cariLokasi = TextEditingController();

  LatLng _currentPos = const LatLng(3.567261, 98.650062); //Ubah ini kalau mau pakai langsung
  String placeName = "Memuat nama lokasi...";

  final String mapStyle = '''
[
  {
    "elementType": "geometry",
    "stylers": [{"color": "#1d1d2b"}]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#ffffff"}]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [{"color": "#303046"}]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [{"color": "#1a1a27"}]
  }
]
''';

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
  }

  Future<void> _loadUserLocation() async {
    Position position = await _getUserLocation();
    setState(() {
      _currentPos = LatLng(position.latitude, position.longitude);
    });
  }

  Future<Position> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> updatePlaceName(LatLng pos) async {
    try {
      List<Placemark> data = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );

      if (data.isNotEmpty) {
        final p = data.first;
        setState(() {
          placeName = "${p.street}, ${p.subLocality}, ${p.locality}";
        });
      }
    } catch (e) {
      setState(() {
        placeName = "Lokasi tidak ditemukan";
      });
    }
  }
  Future<void> fetchNearestPlace(LatLng pos) async {
    final radius = 150;
    final apiKey = "AIzaSyANgsqr2nJbNIfkg_1EwVbYJUBPz5ALlU8";

    final url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        "?location=${pos.latitude},${pos.longitude}"
        "&radius=$radius"
        "&key=$apiKey";

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    if (data["status"] == "OK") {
      final nearest = data["results"][0];
      setState(() {
        placeName = nearest["name"];
        //nearestAddress = nearest["vicinity"];
      });
    } else {
      setState(() {
        placeName = "Tidak ada tempat terdekat ditemukan";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// --------------------- MAP BACKGROUND ---------------------
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPos,
              zoom: screenWidth * 0.04,
            ),
            style: mapStyle,
            onMapCreated: (controller) => mapController = controller,
            //zoomControlsEnabled: false,
            myLocationEnabled: false,
            onCameraIdle: () async {
              final LatLng center = await mapController!.getLatLng(
                ScreenCoordinate(
                  x: (MediaQuery.of(context).size.width / 2).round(),
                  y: (MediaQuery.of(context).size.height / 2).round(),
                ),
              );

              setState(() => _currentPos = center);

              // Update nama tempat
              //updatePlaceName(center);
              fetchNearestPlace(center);
              print(placeName);//TODO: Nama tempat belum sepenuhnya benar
            },
          ),

          /// --------------------- SEARCH BAR + WAKTU ---------------------
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.025),
                // Search bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  height: screenHeight * 0.05,
                  decoration: BoxDecoration(
                    color: Color(0xFF1A1C3F),
                    borderRadius: BorderRadius.circular(screenWidth * 0.08),
                  ),
                  child: SizedBox(
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white.withValues(alpha: 0.4)),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: TextField(
                            controller: cariLokasi,//TODO: fungsi cari lokasi
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Cari lokasi",
                              hintStyle: TextStyle(color: Colors.white54),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// --------------------- BADGE LOKASI + TITIK RAWAN BUTTON ---------------------
          Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: Row(
              children: [
                // Kordinat badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenWidth * 0.02),
                  decoration: BoxDecoration(
                    color: Color(0xFF0D1234),
                    borderRadius: BorderRadius.circular(screenWidth * 0.08),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red, size: screenWidth * 0.04),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        "${_currentPos.latitude.toStringAsFixed(6)}, ${_currentPos.longitude.toStringAsFixed(6)}",
                        style: TextStyle(color: Color(0xFF808094)),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Icon(Icons.copy, size: 16, color: Color(0xFF808094)),
                    ],
                  ),
                ),
                Spacer(),

                // Tombol titik rawan
                GestureDetector(
                  onTap: (){}, //TODO: Tombol titik rawan
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035, vertical: screenWidth * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning,
                          size: screenWidth * 0.045,
                          color: Colors.white,
                        ),
                        SizedBox(width: screenWidth * 0.015,),
                        Text(
                          "Titik Rawan",
                          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          /// --------------------- PIN LOKASI ---------------------
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: screenWidth * 0.04),
              child: Icon(
                Icons.location_pin,
                color: Colors.redAccent,
                size: screenWidth * 0.15,
              ),
            ),
          ),


        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import '../theme/app_colors.dart';
//
// class PetaScreen extends StatelessWidget {
//   const PetaScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.biruVigilanter,
//       body: const Center(
//         child: Text(
//           "Halaman Peta",
//           style: TextStyle(color: Colors.white, fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
