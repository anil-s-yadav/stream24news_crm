// Only import dart:ui as ui on web
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

/// Use conditional import for platform view registry
// ignore: undefined_prefixed_name
import 'dart:ui' as ui;

import 'package:stream24news_crm/screens/video_play_screen.dart';

class WebVideoPlayer extends StatelessWidget {
  const WebVideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    const String viewId = 'web-video-player';

    developer.log('Initializing web video player');

    // Create video element
    final videoElement = html.VideoElement()
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..controls = true;

    // Add HLS.js script
    final script = html.ScriptElement()
      ..src =
          'https://cdn.jsdelivr.net/npm/hls.js@1.4.12' // Using specific version
      ..type = 'application/javascript'
      ..async = true; // Load asynchronously

    html.document.head?.children.add(script);

    script.onLoad.listen((_) {
      developer.log('HLS.js script loaded');

      // Check if Hls is actually available
      if (js.context['Hls'] == null) {
        developer.log('Error: HLS.js not loaded properly');
        return;
      }

      // Check if HLS.js is supported
      if (js.context['Hls'].callMethod('isSupported')) {
        developer.log('HLS.js is supported');
        try {
          // final hls = js.context['Hls'].newObject();
          final hls = js.JsObject(js.context['Hls']); // correct instantiation

          // Add error handling
          hls.callMethod('on', [
            'error',
            js.allowInterop((_, dynamic data) {
              developer.log('HLS error: $data');
            })
          ]);

          developer.log('Loading source: $hlsUrl');
          hls.callMethod('loadSource', [hlsUrl]);
          hls.callMethod('attachMedia', [videoElement]);

          hls.callMethod('on', [
            'hlsManifestParsed',
            js.allowInterop(() {
              developer.log('HLS manifest parsed, attempting playback');
              videoElement.play().then((_) {
                developer.log('Playback started');
              }).catchError((error) {
                developer.log('Playback error: $error');
              });
            })
          ]);
        } catch (e) {
          developer.log('Error initializing HLS.js: $e');
        }
      } else {
        developer.log('Trying native playback');
        if (videoElement.canPlayType('application/vnd.apple.mpegurl') != '') {
          // For Safari which has native HLS support
          videoElement.src = hlsUrl;
          videoElement.play();
        } else {
          developer.log('Neither HLS.js nor native HLS playback is supported');
        }
      }
    });

    script.onError.listen((event) {
      developer.log('Error loading HLS.js script: $event');
    });

    // Register view factory
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory(viewId, (int _) => videoElement);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: const Center(
        child: HtmlElementView(viewType: viewId),
      ),
    );
  }
}
