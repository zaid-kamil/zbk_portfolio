import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class IframeView extends StatefulWidget {
  final String src;

  const IframeView({super.key, required this.src});

  @override
  State<IframeView> createState() => _IframeViewState();
}

class _IframeViewState extends State<IframeView> {
  final IFrameElement _iframeElement = IFrameElement();

  @override
  void initState() {
    super.initState();
    _iframeElement
      ..style.border = 'none'
      ..allowFullscreen = true
      ..allow =
          'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture'
      ..src = widget.src;


  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(
      viewType: widget.src,
    );
  }
}
