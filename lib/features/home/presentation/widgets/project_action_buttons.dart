import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectActionButtons extends StatelessWidget {
  final String? githubUrl;
  final String? liveDemoUrl;

  const ProjectActionButtons({super.key, this.githubUrl, this.liveDemoUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (githubUrl != null)
            ElevatedButton.icon(
              icon: const Icon(Icons.code),
              label: const Text('GitHub'),
              onPressed: () => launchUrl(Uri.parse(githubUrl!)),
            ),
          if (liveDemoUrl != null)
            ElevatedButton.icon(
              icon: const Icon(Icons.launch),
              label: const Text('Live Demo'),
              onPressed: () => launchUrl(Uri.parse(liveDemoUrl!)),
            ),
        ],
      ),
    );
  }
}