import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // final String mapStyle = '''
  // [ ... gaya map kamu ... ]
  // ''';

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
  }

  /// AMBIL LOKASI USER → UPDATE MARKER
  Future<void> _loadUserLocation() async {
    Position? position = await locationService.getPosition();

    if (position == null) return;

    _currentPos = LatLng(position.latitude, position.longitude);

    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId("userPos"),
          position: _currentPos,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),

          // Kalau Marker diklik
          onTap: () {
            debugPrint("Marker lokasi user diklik!");

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text("Lokasi User")),
            // );
          },

          // Info Window (muncul di atas marker)
          infoWindow: InfoWindow(
            title: "Lokasi User",
            snippet: "Ini adalah lokasi Anda saat ini",
          ),
        ),
      );
    });

    // GERAKKAN KAMERA KE LOKASI USER
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPos, 16),
      );
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
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPos,
              zoom: 16,                // ZOOM NORMAL, tidak pakai screenWidth
            ),
            markers: markers,
            myLocationEnabled: false, // kamu pakai marker manual
            onMapCreated: (controller) async {
              mapController = controller;

              // apply map style
              // await controller.setMapStyle(mapStyle);

              // setelah map siap → pindahkan kamera (jika lokasinya sudah didapat)
              controller.animateCamera(
                CameraUpdate.newLatLngZoom(_currentPos, 16),
              );
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
                      GestureDetector(
                        onTap: () {
                          final text =
                              "${_currentPos.latitude.toStringAsFixed(6)}, ${_currentPos.longitude.toStringAsFixed(6)}";

                          Clipboard.setData(ClipboardData(text: text));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Koordinat disalin ke clipboard!"),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 2),
                              margin: EdgeInsets.only(
                                bottom: screenHeight * 0.033,
                              ),
                            ),
                          );
                        },
                        child: Icon(Icons.copy, size: 16, color: Color(0xFF808094)),
                      ),
                    ],
                  )
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

