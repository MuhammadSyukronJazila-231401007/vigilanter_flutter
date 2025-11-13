import 'package:flutter/material.dart';
import 'package:vigilanter_flutter/widgets/app_scaffold.dart';

class DetailLaporan extends StatelessWidget {
  const DetailLaporan({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double baseFont = screenWidth * 0.035;

    return AppScaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.06),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: screenWidth * 0.09,
                        ),
                        onPressed: () {
                          //Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Judul laporan
                  Text(
                    "Begal Motor",
                    style: TextStyle(
                      fontSize: screenWidth * 0.065,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Lokasi
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: screenWidth * 0.1,
                        width: screenWidth * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.location_on,
                            color: Colors.white70, size: screenWidth * 0.06),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Simpang Tiga Kampus USU",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: baseFont * 1.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "3.567261, 98.650062",
                                    style: TextStyle(
                                      color:
                                          Colors.white.withValues(alpha: 0.4),
                                      fontSize: baseFont * 0.95,
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.015),
                                Icon(Icons.save,
                                    size: screenWidth * 0.045,
                                    color: Colors.white.withValues(alpha: 0.7))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Tanggal & waktu
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: screenWidth * 0.1,
                        width: screenWidth * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.calendar_month_outlined,
                            color: Colors.white70, size: screenWidth * 0.06),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jumat, 21 Juni 2024",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: baseFont * 1.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "(21:03:21 WIB)",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: baseFont * 0.95,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Jenis & status
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jenis Laporan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: baseFont * 1.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.22),
                      Text(
                        "Status",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: baseFont * 1.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Laporan Manual",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: baseFont,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.1),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.004,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.05),
                        ),
                        child: Text(
                          "Diajukan",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: baseFont,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Deskripsi & bukti
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Deskripsi Laporan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: baseFont * 1.05,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {}, // TODO: Edit function
                        icon: Icon(
                          Icons.mode_edit_outlined,
                          color: Colors.white,
                          size: screenWidth * 0.06, // lebih besar & proporsional
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Pada tanggal 21 Juni 2024 sekitar pukul 20.50 WIB, telah terjadi kejahatan begal di Simpang Tiga Kampus USU. Korban dihentikan oleh dua orang tidak dikenal yang mengendarai sepeda motor tanpa plat nomor. Kedua pelaku mengenakan helm full face dan jaket hitam. Pelaku mengancam korban dengan senjata tajam dan memaksa menyerahkan motornya. Setelah mengambil barang-barang milik korban, pelaku melarikan diri ke arah Jalan Dr. Mansyur. Korban tidak mengalami luka fisik namun mengalami shock dan trauma akibat kejadian tersebut.",
                    style: TextStyle(
                      color: Colors.white70,
                      height: 1.5,
                      fontSize: baseFont,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  Text(
                    "Bukti Video/Foto",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: baseFont * 1.05,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Center(
                    child: Icon(
                      Icons.image,
                      color: Colors.white54,
                      size: screenWidth * 0.3,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
