import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProjectImage extends StatelessWidget {
  final String? imageUrl;
  final String title;

  const ProjectImage({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) return const SizedBox.shrink();

    return Hero(
      tag: 'project-image-${title.hashCode}',
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            imageUrl!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
