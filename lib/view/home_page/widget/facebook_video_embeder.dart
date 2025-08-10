import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui_web;

class FacebookVideoEmbedder extends StatefulWidget {
  final String videoUrl;
  final String uniqueId;
  final double height;
  final ScrollController
  scrollController; // Pass the main page's ScrollController

  const FacebookVideoEmbedder({
    super.key,
    required this.videoUrl,
    required this.uniqueId,
    required this.height,
    required this.scrollController,
  });

  @override
  State<FacebookVideoEmbedder> createState() => _FacebookVideoEmbedderState();
}

class _FacebookVideoEmbedderState extends State<FacebookVideoEmbedder> {
  late String _viewType;
  bool _isOverlayActive = true;
  web.HTMLIFrameElement? _iframeElement;

  @override
  void initState() {
    super.initState();
    _viewType = 'facebook-video-iframe-${widget.uniqueId}';
    _registerIframeViewFactory();
  }

  void _registerIframeViewFactory() {
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      _iframeElement = web.HTMLIFrameElement()
        ..src = widget.videoUrl
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allowFullscreen = true
        ..style.pointerEvents = 'none'
        ..setAttribute(
          'allow',
          'autoplay; clipboard-write; encrypted-media; picture-in-picture; web-share',
        );

      return _iframeElement!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          // This is the only instance of HtmlElementView
          HtmlElementView(viewType: _viewType),

          if (_isOverlayActive)
            Positioned.fill(
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  // Manually scroll the parent page using its ScrollController
                  widget.scrollController.jumpTo(
                    widget.scrollController.offset - details.delta.dy,
                  );
                },
                onTap: () {
                  setState(() {
                    _isOverlayActive = false; // Hide overlay on tap
                    _iframeElement?.style.pointerEvents =
                        'auto'; // Enable pointer events for the iframe
                  });
                },
                child: Container(
                  color: Colors.transparent, // Make it transparent
                ),
              ),
            ),
        ],
      ),
    );
  }
}
