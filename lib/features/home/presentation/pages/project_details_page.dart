import 'package:flutter/material.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (project.imageUrl != null)
              Hero(
                tag: 'project-image-${project.title.hashCode}',
                child: SizedBox(
                  width: double.infinity,
                  child: InteractiveViewer(
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Image.network(
                      project.imageUrl!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
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
          ],
        ),
      ),
    );
  }
}