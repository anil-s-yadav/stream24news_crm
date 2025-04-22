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
  final String url;

  const WebVideoPlayer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final String viewId =
        'web-video-player-${DateTime.now().millisecondsSinceEpoch}';
    developer.log('Initializing web video player for $url');

    final videoElement = html.VideoElement()
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..controls = true;

    final script = html.ScriptElement()
      ..src = 'https://cdn.jsdelivr.net/npm/hls.js@1.4.12'
      ..type = 'application/javascript'
      ..async = true;

    html.document.head?.children.add(script);

    script.onLoad.listen((_) {
      if (js.context['Hls'] == null) return;

      if (js.context['Hls'].callMethod('isSupported')) {
        final hls = js.JsObject(js.context['Hls']);

        hls.callMethod('loadSource', [url]);
        hls.callMethod('attachMedia', [videoElement]);

        hls.callMethod('on', [
          'hlsManifestParsed',
          js.allowInterop(() {
            videoElement.play().catchError((error) {
              developer.log('Playback error: $error');
            });
          })
        ]);
      } else if (videoElement.canPlayType('application/vnd.apple.mpegurl') !=
          '') {
        videoElement.src = url;
        videoElement.play();
      }
    });

    // Register view with a unique ID
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory(viewId, (int _) => videoElement);

    return Container(
      color: Colors.black,
      child: HtmlElementView(viewType: viewId),
    );
  }
}
