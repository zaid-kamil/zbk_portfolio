import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';

class ProjectDetailsModal extends StatelessWidget {
  final Project project;

  const ProjectDetailsModal({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            if (project.imageUrl != null) ...[
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  project.imageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            const SizedBox(height: 16),
            Text(
              project.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.technologies
                  .map((tech) => Chip(
                        label: Text(tech),
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.1),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (project.githubUrl != null)
                  TextButton.icon(
                    icon: const Icon(Icons.code),
                    label: const Text('View Code'),
                    onPressed: () => launchUrl(Uri.parse(project.githubUrl!)),
                  ),
                const SizedBox(width: 8),
                if (project.url != null)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.launch),
                    label: const Text('Live Demo'),
                    onPressed: () => launchUrl(Uri.parse(project.url!)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
