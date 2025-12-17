<div align="center">
  <img src="assets/images/vigilanter_logo.png" alt="Logo Vigilanter" height="450" />
</div>


# 🚨 Vigilanter

Vigilanter adalah aplikasi mobile berbasis **Flutter** yang dirancang untuk membantu masyarakat **melaporkan tindak kejahatan secara cepat, akurat, dan berbasis lokasi**, dengan dukungan **unggahan video**, **notifikasi real-time**, serta **integrasi peta**.

Aplikasi ini dikembangkan sebagai **Proyek Akhir** dan memanfaatkan layanan **Firebase** sebagai backend utama.

---

## 🎯 Tujuan Aplikasi

- Mempermudah masyarakat dalam **melaporkan kejahatan di sekitar mereka**
- Menyediakan **bukti visual (video)** sebagai pendukung laporan
- Memberikan **peringatan dini** kepada pengguna lain di sekitar lokasi kejadian
- Mendukung konsep **keamanan berbasis komunitas (community-based vigilance)**

---

## ✨ Fitur Utama

### 📹 Pelaporan Kejahatan Berbasis Video
- Rekam atau pilih video sebagai bukti laporan
- Upload video ke Firebase Storage
- Proses upload berjalan **di background** (non-blocking)

### 📝 Jenis Laporan
- **Laporan Manual** → laporan kejadian kejahatan langsung
- **Bukti Tambahan** → bukti tambahan pada lokasi kejadian yang sama

### 📍 Lokasi Otomatis
- Mengambil lokasi pengguna secara real-time
- Menampilkan alamat/jalan hasil reverse geocoding
- Lokasi laporan ditampilkan di peta

### 🗺️ Peta Interaktif
- Marker laporan kejahatan berdasarkan status
- Navigasi otomatis ke lokasi laporan
- Tombol refresh untuk memperbarui data peta

### 🔔 Notifikasi Real-Time
- Firebase Cloud Messaging (FCM)
- Notifikasi saat laporan dinyatakan valid
- Klik notifikasi langsung membuka peta di lokasi kejadian

### ⏫ Floating Upload Status (UX Improvement)
- Progress upload video ditampilkan sebagai **floating UI**
- Tidak mengganggu halaman utama (Home)
- Status:
  - Uploading (progress %)
  - Success
  - Error
- Elemen otomatis menghilang setelah beberapa detik

### 👤 Autentikasi Pengguna
- Firebase Authentication
- Login & logout pengguna

---

## 🧱 Arsitektur & Teknologi

### Frontend
- **Flutter**
- State Management: **Provider**
- UI responsif dan dinamis

### Backend (Cloud)
- **Firebase Firestore** → penyimpanan data laporan
- **Firebase Storage** → penyimpanan video
- **Firebase Cloud Functions** → logika server & notifikasi
- **Firebase Cloud Messaging** → push notification

---


## 🎨 Color Palette

| Nama | Warna |
|----|----|
| Biru Vigilanter | `#000229` |
| Biru Gelap | `#1B1E3F` |
| Abu Tua | `#585A74` |
| Abu Muda | `#787A95` |
| Kuning Vigilanter | `#FEE600` |

---

## 🚀 Alur Penggunaan Singkat

1. User membuka aplikasi & login
2. Tekan tombol **Lapor**
3. Rekam video kejadian
4. Isi detail laporan
5. Tekan **Kirim**
6. User langsung diarahkan ke Home
7. Upload berjalan di background dengan progress
8. Status berhasil/gagal ditampilkan otomatis

---

## ⚠️ Catatan Penting

- Aplikasi membutuhkan izin:
  - Kamera
  - Lokasi
  - Penyimpanan
  - Notifikasi
- Koneksi internet diperlukan untuk upload & sinkronisasi data
- Video direkomendasikan **≤ 10 MB** untuk pengalaman optimal

---

## 📌 Status Pengembangan

✅ Core features selesai  
✅ UX upload background diterapkan  
✅ Notifikasi & peta terintegrasi  
🔜 Pengembangan lanjutan (opsional):
- Kompresi video otomatis
- Riwayat laporan user
- Mode offline draft

---

## 👨‍💻 Pengembang

**Nama:** _Muhammad Syukron Jazila, Timothy Tanawi, & Anugrah Syahputra Sibarani_  
**Institusi:** _Universitas Sumatera Utara_  
**Mata Kuliah:** Pemrograman Mobile  
**Tahun:** 2025

---

## 📄 Lisensi

[MIT](https://choosealicense.com/licenses/mit/)

Aplikasi ini dikembangkan untuk **keperluan akademik** dan **non-komersial**.

