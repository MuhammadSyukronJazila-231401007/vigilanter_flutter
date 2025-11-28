import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class VideoRecordScreen extends StatefulWidget {
  const VideoRecordScreen({super.key});

  @override
  State<VideoRecordScreen> createState() => _VideoRecordScreenState();
}

class _VideoRecordScreenState extends State<VideoRecordScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  int _cameraIndex = 0;

  bool _isRecording = false;
  bool _flashOn = false;

  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();

    _controller = CameraController(
      _cameras![_cameraIndex],
      ResolutionPreset.high,
      enableAudio: true,
    );

    await _controller!.initialize();
    if (!mounted) return;

    setState(() {});
  }

  // Flip camera
  Future<void> _flipCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;

    _cameraIndex = (_cameraIndex + 1) % _cameras!.length;

    await _controller?.dispose();
    await _initCamera();
  }

  // Toggle flash
  Future<void> _toggleFlash() async {
    if (_controller == null) return;

    _flashOn = !_flashOn;
    await _controller!.setFlashMode(
      _flashOn ? FlashMode.torch : FlashMode.off,
    );
    setState(() {});
  }

  // Timer
  void _startTimer() {
    _seconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  String _formatTime(int sec) {
    final m = (sec ~/ 60).toString().padLeft(2, '0');
    final s = (sec % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  // Start recording
  Future<void> _startRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    
    final directory = Directory('/storage/emulated/0/DCIM/Vigilanter');
    if (!directory.existsSync()) {
        directory.createSync(recursive: true);
    }
    final filePath = "${directory.path}/VID_${DateTime.now().millisecondsSinceEpoch}.mp4";

    await _controller!.startVideoRecording();

    _isRecording = true;
    _startTimer();
    setState(() {});
  }

  // Stop and return file
  Future<void> _stopRecording() async {
    if (_controller == null || !_controller!.value.isRecordingVideo) return;

    _stopTimer();

    final file = await _controller!.stopVideoRecording();
    _isRecording = false;
    setState(() {});

    // Kembalikan file video ke screen sebelumnya
    Navigator.pop(context, File(file.path));
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _controller == null || !_controller!.value.isInitialized
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : Stack(
                children: [
                  // Camera Preview
                  Positioned.fill(
                    child: FittedBox(
                      fit: BoxFit.cover, // memenuhi layar tapi tetap proporsional
                      child: SizedBox(
                        width: _controller!.value.previewSize!.height,
                        height: _controller!.value.previewSize!.width,
                        child: CameraPreview(_controller!),
                      ),
                    ),
                  ),

        
                  // Instruction Text (Top)
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      color: Colors.black.withOpacity(0.5),
                      child: const Text(
                        "Fokuskan kamera pada wajah pelaku atau plat kendaraan dengan pencahayaan yang cukup.\n"
                        "Selama merekam, sebutkan deskripsi kejadian secara langsung.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
        
                  // Timer
                  if (_isRecording)
                    Positioned(
                      top: 110,
                      left: 20,
                      child: Text(
                        _formatTime(_seconds),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
        
                  // Flash button
                  Positioned(
                    top: 120,
                    right: 20,
                    child: IconButton(
                      icon: Icon(
                        _flashOn ? Icons.flash_on : Icons.flash_off,
                        size: 32,
                        color: Colors.white,
                      ),
                      onPressed: _toggleFlash,
                    ),
                  ),
        
                  // Flip camera
                  Positioned(
                    top: 180,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(Icons.cameraswitch, size: 32, color: Colors.white),
                      onPressed: _flipCamera,
                    ),
                  ),
        
                  // Bottom Record Button
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _isRecording ? _stopRecording : _startRecording,
                        child: Container(
                          width: 85,
                          height: 85,
                          decoration: BoxDecoration(
                            color: _isRecording ? Colors.red : Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
