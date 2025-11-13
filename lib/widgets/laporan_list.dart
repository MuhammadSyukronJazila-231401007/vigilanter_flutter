import 'package:flutter/material.dart';
import '../data/data_laporan.dart';

class LaporanList extends StatelessWidget {
  final List<Laporan> laporanTerkirim;
  final List<Laporan> laporanSelesai;
  final Function(int) onHapusTerkirim;
  final Function(int) onHapusSelesai;
  final double paddingVertical;
  final double sectionTitleSize;

  const LaporanList({
    required this.laporanTerkirim,
    required this.laporanSelesai,
    required this.onHapusTerkirim,
    required this.onHapusSelesai,
    required this.paddingVertical,
    required this.sectionTitleSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardFontSizeTitle = size.width * 0.04;
    final cardFontSizeSub = size.width * 0.028;
    final cardPadding = size.width * 0.04;
    final iconSize = size.width * 0.05;

    return ListView(
      children: [
        // Terkirim Section
        SectionHeader(title: 'Terkirim', fontSize: sectionTitleSize),
        SizedBox(height: paddingVertical),
        ...laporanTerkirim.asMap().entries.map((entry) {
          int index = entry.key;
          Laporan laporan = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: paddingVertical * 1.5),
            child: ReportCard(
              laporan: laporan,
              cardPadding: cardPadding,
              iconSize: iconSize,
              titleFontSize: cardFontSizeTitle,
              subFontSize: cardFontSizeSub,
              showBatalkan: true,
              onBatalkan: () => onHapusTerkirim(index),
            ),
          );
        }),
        SizedBox(height: paddingVertical * 2),
        // Selesai Section
        SectionHeader(title: 'Selesai', fontSize: sectionTitleSize),
        SizedBox(height: paddingVertical),
        ...laporanSelesai.asMap().entries.map((entry) {
          int index = entry.key;
          Laporan laporan = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: paddingVertical * 1.5),
            child: ReportCard(
              laporan: laporan,
              cardPadding: cardPadding,
              iconSize: iconSize,
              titleFontSize: cardFontSizeTitle,
              subFontSize: cardFontSizeSub,
              showBatalkan: false,
              onHapus: () => onHapusSelesai(index),
            ),
          );
        }),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final double fontSize;
  const SectionHeader({required this.title, required this.fontSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              //fontWeight: FontWeight.w600,
              fontSize: fontSize),
        ),
        const Spacer(),
        const Icon(
          Icons.sort,
          color: Colors.white54,
          size: 20,
        ),
      ],
    );
  }
}

class ReportCard extends StatelessWidget {
  final Laporan laporan;
  final double cardPadding;
  final double iconSize;
  final double titleFontSize;
  final double subFontSize;
  final bool showBatalkan;
  final VoidCallback? onBatalkan;
  final VoidCallback? onHapus;

  const ReportCard({
    required this.laporan,
    required this.cardPadding,
    required this.iconSize,
    required this.titleFontSize,
    required this.subFontSize,
    required this.showBatalkan,
    this.onBatalkan,
    this.onHapus,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = laporan.status.toLowerCase() == 'diterima'
        ? Colors.green
        : laporan.status.toLowerCase() == 'ditolak'
        ? Colors.redAccent
        : Colors.red;

    return GestureDetector(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0B0E3B),
          borderRadius: BorderRadius.circular(iconSize * 0.3),
        ),
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.report,
                  color: Colors.white,
                  size: iconSize * 1.1,
                ),
                SizedBox(width: cardPadding / 2),
                Expanded(
                  child: Text(
                    laporan.judul,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: titleFontSize),
                  ),
                ),
                if (!showBatalkan)
                  Text(
                    laporan.status,
                    style: TextStyle(
                        color: statusColor,
                        fontSize: subFontSize * 1.25,
                        fontWeight: FontWeight.w600),
                  ),
              ],
            ),
            Divider(
              color: Color(0xFFFFFFFF).withValues(alpha: 0.25),
              height: 20,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: iconSize * 0.85,
                ),
                SizedBox(width: cardPadding / 1.5),
                Expanded(
                  child: Text(
                    laporan.lokasi,
                    style: TextStyle(color: Colors.white70, fontSize: subFontSize * 1.05),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: iconSize * 0.85,
                ),
                SizedBox(width: cardPadding / 1.5),
                Expanded(
                  child: Text(
                    laporan.tanggal,
                    style: TextStyle(color: Colors.white70, fontSize: subFontSize * 1.05),
                  ),
                ),
                if (showBatalkan)
                  SizedBox(
                    height: iconSize * 1.4,
                    child: TextButton(
                      onPressed: onBatalkan,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(
                            horizontal: cardPadding / 2,
                            vertical: cardPadding / 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(iconSize * 0.4)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.not_interested,
                            size: subFontSize * 1.5,
                            color: Colors.white,
                          ),
                          SizedBox(width: cardPadding * 0.4),
                          Text(
                            'Batalkan',
                            style: TextStyle(color: Colors.white, fontSize: subFontSize),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SizedBox(
                    height: iconSize * 1.4,
                    child: TextButton(
                      onPressed: onHapus,
                      style: TextButton.styleFrom(
                        side: BorderSide(color: Colors.white54),
                        backgroundColor: Colors.white.withValues(alpha: 0.5),
                        padding: EdgeInsets.symmetric(
                            horizontal: cardPadding / 2,
                            vertical: cardPadding / 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(iconSize * 0.4)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline_outlined,
                            size: subFontSize * 1.5,
                            color: Color(0xFF000229),
                          ),
                          Text(
                            'Hapus',
                            style: TextStyle(color: Color(0xFF000229), fontSize: subFontSize),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}