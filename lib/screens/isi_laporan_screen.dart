import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:vigilanter_flutter/config/router.dart';

import '../theme/app_colors.dart';


class IsiLaporanScreen extends StatefulWidget {
  @override
  _IsiLaporanScreenState createState() => _IsiLaporanScreenState();
}

class _IsiLaporanScreenState extends State<IsiLaporanScreen> {
  final TextEditingController namaKejahatanController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController namaPelaporController = TextEditingController(text: 'Simpang Sumarsono'); //TODO:

  final int maxNamaKejahatanLength = 20;

  final List<String> laporanOptions = ['Laporan Manual', 'Bukti Tambahan'];
  String selectedLaporan = 'Laporan Manual';

  void onPratinjauVideoTap() {
    //print('Pratinjau Video ditekan');
    //TODO: Fungsi Pratinjau video
  }

  void onGunakanTeksTap() {
    //print('Gunakan Teks dalam video ditekan');
    //TODO: Fungsi Gunakan teks dalam video
  }

  bool get isManualFormValid {
    // Wajib diisi
    return namaKejahatanController.text.trim().isNotEmpty &&
        deskripsiController.text.trim().isNotEmpty &&
        namaKejahatanController.text.length <= 20;
  }

  bool get isBuktiTambahanFormValid {

    return namaPelaporController.text.trim().isNotEmpty &&
        namaKejahatanController.text.trim().isNotEmpty &&
        deskripsiController.text.trim().isNotEmpty &&
        namaKejahatanController.text.length <= 20;
  }

  @override
  void initState() {
    super.initState();

    namaKejahatanController.addListener(() => setState(() {}));
    deskripsiController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    namaKejahatanController.dispose();
    deskripsiController.dispose();
    namaPelaporController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final paddingHor = screenWidth * 0.05;

    bool isFormValid = selectedLaporan == 'Laporan Manual'
        ? isManualFormValid
        : isBuktiTambahanFormValid;
    bool charLimit = namaKejahatanController.text.length <= 20;

    return Scaffold(
      backgroundColor: AppColors.biruVigilanter,
      appBar: AppBar(
        backgroundColor: Color(0xFF000229),
        elevation: 0,
        leadingWidth: screenWidth * 0.15,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: screenWidth * 0.08,),
          onPressed: () {} //TODO: Navigation
        ),
        title: Text('Buat Laporan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.07),),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHor,
            vertical: screenHeight * 0.01,
          ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lokasi
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white54,
                      size: screenWidth * 0.04,
                    ),
                    SizedBox(width: 5),
                    //TODO: Sesuaikan dengan lokasi pengguna
                    Expanded(
                      child: Text(
                        'Lokasi Anda : Simpang Tiga Kampus USU (3.567261, 98.660062)',
                        style: TextStyle(
                          fontSize: screenWidth * 0.033,
                          color: Colors.white54,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.01),

                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.05,),
                    GestureDetector(
                      onTap: onPratinjauVideoTap,
                      child: Text(
                        'Pratinjau Video',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Color(0xFF8C8D9F),
                          decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF8C8D9F),
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    if (selectedLaporan == 'Laporan Manual') ...[
                    SizedBox(width: screenWidth * 0.06,),
                    GestureDetector(
                      onTap: onGunakanTeksTap,
                      child: Text(
                        'Gunakan Teks dalam video',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Color(0xFF8C8D9F),
                          decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF8C8D9F),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    )]
                  ],
                ),

                SizedBox(height: screenHeight * 0.02),

                // Dropdown Jenis Laporan
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  height: screenHeight * 0.06,
                  decoration: BoxDecoration(
                    color: Color(0xFF1A1C40),
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedLaporan,
                      dropdownColor: Color(0xFF1A1C40),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: screenWidth * 0.038,
                      ),
                      isExpanded: true,
                      iconEnabledColor: Colors.white70,
                      items: laporanOptions
                          .map(
                            (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedLaporan = val!;
                          // Reset controllers ketika ganti tipe laporan
                          namaKejahatanController.clear();
                          deskripsiController.clear();
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                // UI berbeda sesuai pilihan dropdown
                if (selectedLaporan == 'Laporan Manual') ...[
                  // Input Nama Kejahatan
                  TextField(
                    controller: namaKejahatanController,
                    maxLengthEnforcement: MaxLengthEnforcement.none,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixText: '${namaKejahatanController.text.length}/$maxNamaKejahatanLength',
                      suffixStyle: TextStyle(color: charLimit ? Colors.white54 : Colors.red, fontSize: screenWidth * 0.03),
                      filled: true,
                      fillColor: Color(0xFF1A1C40),
                      hintText: 'Nama Kejahatan',
                      hintStyle: TextStyle(color: Colors.white38),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenWidth * 0.04),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  // Input Deskripsi Kejahatan
                  Expanded(

                    child: TextField(
                      controller: deskripsiController,
                      maxLines: null,
                      expands: true,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF1A1C40),
                        hintText: 'Deskripsi Kejahatan',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenWidth * 0.05),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),
                ] else if (selectedLaporan == 'Bukti Tambahan') ...[
                  // Nama Pelapor
                  // TextField(
                  //   controller: namaPelaporController,
                  //   readOnly: true,
                  //   style: TextStyle(
                  //     color: Colors.white70,
                  //     fontSize: screenWidth * 0.038,
                  //   ),
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: Color(0xFF1A1C40),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  //       borderSide: BorderSide.none,
                  //     ),
                  //     contentPadding:
                  //     EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenWidth * 0.04),
                  //   ),
                  // ),

                  //SizedBox(height: screenHeight * 0.015),

                  // Input Nama Kejahatan
                  TextField(
                    controller: namaKejahatanController,
                    maxLengthEnforcement: MaxLengthEnforcement.none,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      suffixText: '${namaKejahatanController.text.length}/$maxNamaKejahatanLength',
                      suffixStyle: TextStyle(color: charLimit ? Colors.white54 : Colors.red, fontSize: screenWidth * 0.03),
                      filled: true,
                      fillColor: Color(0xFF1A1C40),
                      hintText: 'Nama Kejahatan',
                      hintStyle: TextStyle(color: Colors.white38),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenWidth * 0.04),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  // Input Deskripsi Kejahatan
                  Expanded(
                    child: TextField(
                      controller: deskripsiController,
                      maxLines: null,
                      expands: true,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF1A1C40),
                        hintText: 'Deskripsi Kejahatan',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenWidth * 0.05),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),
                ],

                // Tombol Kirim dengan kondisi aktif / non aktif

                Container(
                  width: double.infinity,
                  height: screenHeight * 0.06,
                  margin: EdgeInsets.only(bottom: screenHeight * 0.1),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFormValid
                          ? Color(0xFFFFE600) // kuning aktif
                          : Color(0xFF3A3C5B), // abu gelap disable
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.035),
                        side: BorderSide(
                          width: screenWidth * 0.0066,
                          color: Color(0xFFFFE600) ,
                        ),
                      ),
                    ),
                    onPressed: isFormValid
                        ? () {
                      context.go(AppRoutes.home);
                      // TODO: Kirim laporan
                    }
                        : null,
                    child: Text(
                      'Kirim',
                      style: TextStyle(
                        color: isFormValid ? Colors.black : Color(0xFFFFE600) ,
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: screenHeight * 0.2,)
              ],
            ),

        ),


    );
  }
}