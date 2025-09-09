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
              tween: Tween<double>(
                begin: isHovered ? 0.0 : 1.0,
                end: isHovered ? 1.0 : 0.0,
              ),
              duration: const Duration(milliseconds: 300),
              builder: (context, value, child) {
                return ColorFiltered(
                  colorFilter: ColorFilter.matrix(<double>[
                    0.2126 + 0.7874 * value,
                    0.7152 - 0.7152 * value,
                    0.0722 - 0.0722 * value,
                    0,
                    0,
                    0.2126 - 0.2126 * value,
                    0.7152 + 0.2848 * value,
                    0.0722 - 0.0722 * value,
                    0,
                    0,
                    0.2126 - 0.2126 * value,
                    0.7152 - 0.7152 * value,
                    0.0722 + 0.9278 * value,
                    0,
                    0,
                    0,
                    0,
                    0,
                    1,
                    0,
                  ]),
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
