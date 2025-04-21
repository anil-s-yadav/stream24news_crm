import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'native_video_player.dart';
import 'web_video_player.dart';

/// HLS stream URL
const String hlsUrl =
    "https://ndtvindiaelemarchana.akamaized.net/hls/live/2003679/ndtvindia/master.m3u8";

class VideoPlayScreen extends StatelessWidget {
  const VideoPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Video")),
      body: const Center(
        child: VideoPlayerWrapper(),
      ),
    );
  }
}

class VideoPlayerWrapper extends StatelessWidget {
  const VideoPlayerWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const WebVideoPlayer();
    } else {
      return const NativeVideoPlayer();
    }
  }
}
