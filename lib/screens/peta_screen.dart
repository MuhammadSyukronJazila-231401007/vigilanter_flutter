import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vigilanter_flutter/models/report_summary.dart';
import 'package:vigilanter_flutter/services/location_service.dart';
import 'package:vigilanter_flutter/services/report_map_service.dart';
import 'package:vigilanter_flutter/widgets/report_summary_sheets.dart';
import 'detail_laporan_screen.dart';

class PetaScreen extends StatefulWidget {
  final double? focusLat;
  final double? focusLng;
  final String? focusReportId;
  final LatLng? focusLatLng;

  const PetaScreen({
    this.focusLat,
    this.focusLng,
    this.focusReportId,
    this.focusLatLng, 
    Key? key,
  }) : super(key: key);

  @override
  State<PetaScreen> createState() => _PetaPageState();
}

class _PetaPageState extends State<PetaScreen> {
  GoogleMapController? mapController;
  TextEditingController cariLokasi = TextEditingController();
  final locationService = LocationService();
  final _reportMapService = ReportMapService();
  StreamSubscription? _markerSub;
  bool _fromNotification = false;

  LatLng _currentPos = const LatLng(3.567261, 98.650062);
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    _fromNotification =
        widget.focusLatLng != null ||
        (widget.focusLat != null && widget.focusLng != null);

    /// PRIORITAS FOKUS DARI NOTIF
    if (widget.focusLatLng != null) {
      _currentPos = widget.focusLatLng!;
    } else if (widget.focusLat != null && widget.focusLng != null) {
      _currentPos = LatLng(widget.focusLat!, widget.focusLng!);
    }

    _loadUserLocation();

    _markerSub =
        _reportMapService.listenMarkers(_onMarkerTap).listen((m) {
      setState(() {
        markers.addAll(m);
      });
    });
  }

  @override
  void dispose() {
    _markerSub?.cancel();
    cariLokasi.dispose();
    mapController?.dispose();
    super.dispose();
  }

  void _onMarkerTap(ReportSummary summary) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return ReportSummarySheet(
          data: summary,
          onDetail: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    DetailLaporanScreen(reportId: summary.id),
              ),
            );
          },
        );
      },
    );
  }

  /// ===================== AMBIL LOKASI USER =====================
    Future<void> _loadUserLocation() async {
    Position? position = await locationService.getPosition();
    if (position == null) return;

    final userPos = LatLng(position.latitude, position.longitude);

    setState(() {
      markers.removeWhere((m) => m.markerId.value == "userPos");
      markers.add(
        Marker(
          markerId: const MarkerId("userPos"),
          position: userPos,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
          infoWindow: const InfoWindow(
            title: "Lokasi Anda",
            snippet: "Posisi saat ini",
          ),
        ),
      );
    });

    /// ⛔ JANGAN override kamera kalau dari notifikasi
    if (_fromNotification) return;

    _currentPos = userPos;

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
              zoom: 16,
            ),
            markers: markers,
            myLocationEnabled: false,
            onMapCreated: (controller) {
              mapController = controller;

              controller.animateCamera(
                CameraUpdate.newLatLngZoom(_currentPos, 16),
              );
            },
          ),

          /// --------------------- SEARCH BAR ---------------------
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1C3F),
                borderRadius:
                    BorderRadius.circular(screenWidth * 0.08),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on,
                      color: Colors.white.withValues(alpha: 0.4)),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: TextField(
                      controller: cariLokasi,
                      style: TextStyle(
                          color:
                              Colors.white.withValues(alpha: 0.4)),
                      decoration: const InputDecoration(
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

          /// --------------------- BADGE KOORDINAT ---------------------
          Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenWidth * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1234),
                    borderRadius:
                        BorderRadius.circular(screenWidth * 0.08),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.red,
                          size: screenWidth * 0.04),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        "${_currentPos.latitude.toStringAsFixed(6)}, "
                        "${_currentPos.longitude.toStringAsFixed(6)}",
                        style:
                            const TextStyle(color: Color(0xFF808094)),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(
                              text:
                                  "${_currentPos.latitude},${_currentPos.longitude}",
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Koordinat disalin ke clipboard!"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Icon(Icons.copy,
                            size: 16, color: Color(0xFF808094)),
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                /// --------------------- TOMBOL TITIK RAWAN ---------------------
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenWidth * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                        BorderRadius.circular(screenWidth * 0.025),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning,
                          size: screenWidth * 0.045,
                          color: Colors.white),
                      SizedBox(width: screenWidth * 0.015),
                      Text(
                        "Titik Rawans",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
