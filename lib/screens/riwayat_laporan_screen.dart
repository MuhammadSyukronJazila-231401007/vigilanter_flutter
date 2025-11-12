import 'package:flutter/material.dart';
import 'package:vigilanter_flutter/widgets/app_scaffold.dart';
import 'package:vigilanter_flutter/widgets/laporan_view.dart';

class RiwayatLaporan extends StatelessWidget {
  const RiwayatLaporan({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AppScaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.06),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight
            ),
            child :  IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.04,),
                  // Judul laporan
                  Text(
                    "Riwayat Laporan Anda",
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Terkirim
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Terkirim',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: screenWidth * 0.05
                        ),
                      ),
                      IconButton(
                        onPressed: (){},//TODO: Icon Button function
                        icon : Icon(
                          Icons.bar_chart,
                          color: Colors.white.withValues(alpha: 0.5),
                          size:  screenWidth * 0.05,
                        )
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  LaporanView(),
                  // Selesai
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Selesai',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: screenWidth * 0.05
                        ),
                      ),
                      IconButton(
                          onPressed: (){},//TODO: Icon Button function
                          icon : Icon(
                            Icons.bar_chart,
                            color: Colors.white.withValues(alpha: 0.5),
                            size:  screenWidth * 0.05,
                          )
                      )
                    ],
                  ),
                  LaporanView(),
                  SizedBox(height: screenHeight * 0.02),

                ],
              ),
            )

          ),
        ),
      ),
    );
  }
}
