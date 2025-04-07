import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';

class ProjectDetailsModal extends StatefulWidget {
  final Project project;

  const ProjectDetailsModal({super.key, required this.project});

  @override
  State<ProjectDetailsModal> createState() => _ProjectDetailsModalState();
}

class _ProjectDetailsModalState extends State<ProjectDetailsModal> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
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
                      widget.project.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              if (widget.project.imageUrl != null) ...[
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      width: double.infinity,
                      widget.project.imageUrl ?? 'assets/images/default.png',
                      errorBuilder: (_, __, ___) => const Center(
                        child: Image(
                          image: AssetImage('assets/images/default.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Text(
                widget.project.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.project.technologies
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
                  if (widget.project.githubUrl != null)
                    TextButton.icon(
                      icon: const Icon(Icons.code),
                      label: const Text('View Code'),
                      onPressed: () => launchUrl(Uri.parse(widget.project.githubUrl!)),
                    ),
                  const SizedBox(width: 8),
                  if (widget.project.url != null)
                    ElevatedButton.icon(
                      icon: const Icon(Icons.launch),
                      label: const Text('Live Demo'),
                      onPressed: () => launchUrl(Uri.parse(widget.project.url!)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
