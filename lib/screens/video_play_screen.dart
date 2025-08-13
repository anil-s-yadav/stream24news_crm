import 'dart:developer';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'native_video_player.dart';
import 'web_video_player.dart';

/// HLS stream URL
// const String hlsUrl =
//     "https://ndtvindiaelemarchana.akamaized.net/hls/live/2003679/ndtvindia/master.m3u8";

class VideoPlayScreen extends StatelessWidget {
  const VideoPlayScreen({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Video")),
      body: Center(
        child: VideoPlayerWrapper(url: url),
      ),
    );
  }
}

class VideoPlayerWrapper extends StatelessWidget {
  const VideoPlayerWrapper({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      log("web");
      return WebVideoPlayer(url: url);
    } else {
      log("phone");
      return NativeVideoPlayer(url: url);
    }
  }
}
