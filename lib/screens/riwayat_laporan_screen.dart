import 'package:flutter/material.dart';

import '../data/data_laporan.dart';
import '../theme/app_colors.dart';
import '../widgets/Laporan_list.dart';



class RiwayatLaporan extends StatefulWidget {
  const RiwayatLaporan({super.key});

  @override
  _RiwayatLaporanScreenState createState() => _RiwayatLaporanScreenState();
}

class _RiwayatLaporanScreenState extends State<RiwayatLaporan> {


  // Fungsi untuk menghapus laporan
  void _hapusLaporan(List<Laporan> list, int index) {
    setState(() {
      list.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paddingHorizontal = size.width * 0.05;
    final paddingVertical = size.height * 0.02;
    final titleFontSize = size.width * 0.08;
    final sectionTitleSize = size.width * 0.05;

    return Scaffold(
      backgroundColor: AppColors.biruVigilanter,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Riwayat Laporan\nAnda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: paddingVertical * 2),
              Expanded(
                child: LaporanList(
                  laporanTerkirim: laporanTerkirim,
                  laporanSelesai: laporanSelesai,
                  onHapusTerkirim: (index) => _hapusLaporan(laporanTerkirim, index),
                  onHapusSelesai: (index) => _hapusLaporan(laporanSelesai, index),
                  paddingVertical: paddingVertical,
                  sectionTitleSize: sectionTitleSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
