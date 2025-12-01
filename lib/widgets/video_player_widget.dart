import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String? localPath;
  final String? url;

  const VideoPlayerWidget({
    super.key,
    required this.localPath,
    required this.url,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _controller;
  ChewieController? _chewie;

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  Future<void> initVideo() async {
    // 1. Coba pakai video lokal
    if (widget.localPath != null) {
      try {
        final file = File.fromUri(Uri.parse(widget.localPath!));
        if (await file.exists()) {
          _controller = VideoPlayerController.file(file);
        }
      } catch (_) {}
    }

    // 2. Jika gagal → gunakan URL
    if (_controller == null && widget.url != null) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url!));
    }

    if (_controller == null) return;

    await _controller!.initialize();

    _chewie = ChewieController(
      videoPlayerController: _controller!,
      autoPlay: false,
      looping: false,
      allowPlaybackSpeedChanging: true,
      allowFullScreen: true,
    );

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _chewie?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chewie == null) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return AspectRatio(
      aspectRatio: _controller!.value.aspectRatio,
      child: Chewie(controller: _chewie!),
    );
  }
}
