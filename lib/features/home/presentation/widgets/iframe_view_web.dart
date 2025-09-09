import 'dart:ui_web' as ui; // Web-only platform view registry

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class IframeView extends StatefulWidget {
  final String src;

  const IframeView({super.key, required this.src});

  @override
  State<IframeView> createState() => _IframeViewWebState();
}

class _IframeViewWebState extends State<IframeView> {
  late final web.HTMLIFrameElement _iframeElement;
  late final String _viewType;

  @override
  void initState() {
    super.initState();
    // Create iframe element via package:web DOM API
    _iframeElement =
        web.document.createElement('iframe') as web.HTMLIFrameElement;
    _iframeElement
      ..style.border = 'none'
      ..src = widget.src;
    _iframeElement.setAttribute('allowfullscreen', 'true');
    _iframeElement.setAttribute(
      'allow',
      'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture',
    );

    // Use a stable viewType; include hash to avoid duplicates collision when multiple iframes share same src with different params
    _viewType = 'iframe_${widget.src.hashCode}';

    // Register the view factory (web only)
    ui.platformViewRegistry
        .registerViewFactory(_viewType, (int viewId) => _iframeElement);
  }

  @override
  Widget build(BuildContext context) {
    // File is only compiled for web via conditional export.
    return HtmlElementView(viewType: _viewType);
  }
}
