import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload video ke Firebase Storage
  Future<String?> uploadVideo(File videoFile, String userId) async {
    try {
      final String fileName =
          "VID_${userId}_${DateTime.now().millisecondsSinceEpoch}.mp4";

      final ref = _storage.ref().child("reports/videos/$fileName");

      final uploadTask = ref.putFile(videoFile);
      await uploadTask.whenComplete(() {});

      return await ref.getDownloadURL();
    } catch (e) {
      print("Upload video error: $e");
      return null;
    }
  }

  /// Kirim laporan lengkap ke Firestore
  Future<bool> sendLaporan({
    required String userId,
    required String namaKejahatan,
    required String deskripsi,
    required String jenisLaporan,
    required String videoPath,
    required String videoRealPath,
    required double latitude,
    required double longitude,
    required String tempat,
    required String waktuFormatted,
  }) async {
    try {
      await _firestore.collection("reports").add({
        "user_id": userId,
        "nama_kejahatan": namaKejahatan,
        "deskripsi": deskripsi,
        "jenis_laporan": jenisLaporan,
        "video_download_url": videoPath,
        "video_real_path": videoRealPath,
        "latitude": latitude,
        "longitude": longitude,
        "tempat": tempat,
        "status": "Diajukan",
        "waktu": waktuFormatted,
        "created_at": FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      print("Send laporan error: $e");
      return false;
    }
  }
}
