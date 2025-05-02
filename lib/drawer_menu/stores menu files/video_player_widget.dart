import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final File? file;
  final String? networkUrl;

  const VideoPlayerWidget({
    super.key,
    this.file,
    this.networkUrl,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    if (widget.file != null && widget.file!.existsSync()) {
      _controller = VideoPlayerController.file(widget.file!);
    } else if (widget.networkUrl != null && Uri.parse(widget.networkUrl!).isAbsolute) {
      _controller = VideoPlayerController.network(widget.networkUrl!);
    } else {
      throw Exception('No valid video source provided');
    }

    _controller.initialize().then((_) {
      setState(() {
        _initialized = true;
        _controller.setLooping(false);
        _controller.play(); // Autoplay
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: _initialized
              ? SizedBox(
            width: double.infinity,
                child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_controller),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying ? Icons.pause_circle : Icons.play_circle,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
                            ),
                          ),
              )
              : const Center(child: CircularProgressIndicator()),
        ),
      );


    // GestureDetector(
    //   onTap: () {
    //     setState(() {
    //       _controller.value.isPlaying
    //           ? _controller.pause()
    //           : _controller.play();
    //     });
    //   },
    //   child: Icon(
    //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //     color: Colors.white.withOpacity(0.8),
    //   ),
    // ),

  }
}

