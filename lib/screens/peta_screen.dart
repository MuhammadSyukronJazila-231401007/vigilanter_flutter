import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vigilanter_flutter/services/location_service.dart';

class PetaScreen extends StatefulWidget {
  @override
  State<PetaScreen> createState() => _PetaPageState();
}


class _PetaPageState extends State<PetaScreen> {
  GoogleMapController? mapController;
  TextEditingController cariLokasi = TextEditingController();

  final locationService = LocationService();

  LatLng _currentPos = LatLng(3.567261, 98.650062);
  Set<Marker> markers = {};


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
    markers.add(
      Marker(
        markerId: MarkerId("fixedPin"),
        position: _currentPos,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),

      ),
    );
    print("Markers count: ${markers.length}");

  }

  Future<void> _loadUserLocation() async {
    Position? position = await locationService.getPosition();
    setState(() {
      if (position != null){
        _currentPos = LatLng(position.latitude, position.longitude);
      }
    });
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
            myLocationEnabled: false,
            // onCameraIdle: () async {
            //   final LatLng center = await mapController!.getLatLng(
            //     ScreenCoordinate(
            //       x: (MediaQuery.of(context).size.width / 2).round(),
            //       y: (MediaQuery.of(context).size.height / 2).round(),
            //     ),
            //   );
            //   setState(() => _currentPos = center);
            // },
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
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenWidth * 0.02),
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
        ],
      ),
    );
  }
}


