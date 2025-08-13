import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

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

    ui_web.platformViewRegistry
        .registerViewFactory(viewId, (int _) => videoElement);

    return Container(
      color: Colors.black,
      // child: HtmlElementView(viewType: viewId),
    );
  }
}
