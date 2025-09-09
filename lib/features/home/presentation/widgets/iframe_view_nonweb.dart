import 'package:flutter/material.dart';

class IframeView extends StatelessWidget {
  final String src;

  const IframeView({super.key, required this.src});

  @override
  Widget build(BuildContext context) {
    // Non-web fallback: render nothing (or could show a placeholder)
    return const SizedBox.shrink();
  }
}
