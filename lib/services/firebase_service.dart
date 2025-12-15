import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../models/laporan_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseStorage _storage = FirebaseStorage.instance;

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

  // Ambil semua laporan milik user berdasarkan user_id
  Future<List<LaporanModel>> getRiwayatLaporan(String userId) async {
    try {
      final query = await _firestore
          .collection("reports")
          .where("user_id", isEqualTo: userId)
          .get();
    
      return query.docs
          .map((doc) => LaporanModel.fromFirestore(doc.id, doc.data()))
          .toList();
    } catch (e) {
      debugPrint("Error getRiwayatLaporan: $e");
      return [];
    }
  }
  
  Stream<LaporanModel> streamById(String reportId) {
    return FirebaseFirestore.instance
        .collection('reports')
        .doc(reportId)
        .snapshots()
        .map((doc) {
          final data = doc.data();
          if (data == null) {
            throw Exception("Laporan tidak ditemukan");
          }

          return LaporanModel.fromFirestore(
            doc.id,
            data,
          );
        });
  }

  Future<bool> hapusLaporan(String laporanId) async {
    try {
      await _firestore
          .collection('reports')
          .doc(laporanId)
          .delete();

      return true;
    } catch (e) {
      debugPrint("Error hapus laporan: $e");
      return false;
    }
  }

  Future<bool> batalkanLaporan(String laporanId) async {
     try {
       await _firestore
           .collection('reports')
           .doc(laporanId)
           .update({"status": "Dibatalkan"});
       return true;
     } catch (e) {
       debugPrint("Error batalkan laporan: $e");
       return false;
     }
  }

   /// Cek apakah video lokal masih ada
  static Future<bool> isLocalVideoExists(String localPath) async {
    try {
      final file = File.fromUri(Uri.parse(localPath));
      return await file.exists();
    } catch (_) {
      return false;
    }
  }

  /// Ambil download URL dari Firebase Storage (jika ingin refresh)
  static Future<String?> getFreshDownloadUrl(String firebasePath) async {
    try {
      return await _storage.ref(firebasePath).getDownloadURL();
    } catch (_) {
      return null;
    }
  }

}
