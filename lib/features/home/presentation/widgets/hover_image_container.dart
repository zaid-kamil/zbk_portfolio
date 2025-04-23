import 'dart:ui';

import 'package:flutter/material.dart';

class HoverImageContainer extends StatefulWidget {
  final String imageUrl;
  final String heroTag;
  final Widget Function() onErrorBuilder;

  const HoverImageContainer({
    super.key,
    required this.imageUrl,
    required this.heroTag,
    required this.onErrorBuilder,
  });

  @override
  createState() => _HoverImageContainerState();
}

class _HoverImageContainerState extends State<HoverImageContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Hero(
        transitionOnUserGestures: true,
        tag: widget.heroTag,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            // Remove AnimatedScale and animate blur value using TweenAnimationBuilder.
            child: TweenAnimationBuilder<double>(
              key: ValueKey(isHovered),
              tween: Tween<double>(
                begin: isHovered ? 25.0 : 0.0,
                end: isHovered ? 0.0 : 25.0,
              ),
              duration: const Duration(milliseconds: 300),
              builder: (context, blur, child) {
                return ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: child,
                );
              },
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                errorBuilder: (_, __, ___) => widget.onErrorBuilder(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
