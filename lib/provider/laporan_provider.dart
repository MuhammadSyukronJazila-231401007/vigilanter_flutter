import 'package:flutter/material.dart';
import '../models/laporan_model.dart';
import '../services/firebase_service.dart';

class LaporanProvider with ChangeNotifier {
  final FirebaseService _service = FirebaseService();

  List<LaporanModel> _laporanTerkirim = [];
  List<LaporanModel> _laporanSelesai = [];

  List<LaporanModel> get laporanTerkirim => _laporanTerkirim;
  List<LaporanModel> get laporanSelesai => _laporanSelesai;

  Future<void> loadLaporan(String userId) async {
    final allData = await _service.getRiwayatLaporan(userId);
    _laporanTerkirim =
        allData.where((e) => e.status.trim().toLowerCase() == "diajukan").toList();

    _laporanSelesai = allData.where((e) {
      final s = e.status.trim().toLowerCase();
      return s == "diterima" || s == "ditolak" || s == "dibatalkan";
    }).toList();

    notifyListeners();
  }


  Future<void> batalkan(int index) async {
    final laporan = _laporanTerkirim[index];

    await _service.batalkanLaporan(laporan.id);

    final updated = laporan.copyWith(status: "Dibatalkan");

    _laporanTerkirim.removeAt(index);
    _laporanSelesai.add(updated);

    notifyListeners();
  }

  Future<void> hapus(int index, bool dariTerkirim) async {
    final laporan = dariTerkirim
        ? _laporanTerkirim[index]
        : _laporanSelesai[index];

    await _service.hapusLaporan(laporan.id);

    if (dariTerkirim) {
      _laporanTerkirim.removeAt(index);
    } else {
      _laporanSelesai.removeAt(index);
    }

    notifyListeners();
  }
}
