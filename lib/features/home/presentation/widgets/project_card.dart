import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? githubUrl;
  final String? demoUrl;
  final void Function()? onTap;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.githubUrl,
    this.demoUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallCard = constraints.maxWidth < 300;
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // In ProjectCard class, modify the image section
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Hero(
                    tag: 'project-image-${title.hashCode}',
                    // Unique tag for each project
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          child: Image.asset(
                            'assets/images/default.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Content section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isSmallCard ? 14 : 16,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 4),

                        // Description
                        Expanded(
                          child: Text(
                            description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: isSmallCard ? 12 : 14,
                                ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Technologies
                        Wrap(
                          children: technologies
                              .map((tech) => Padding(
                                    padding:
                                        const EdgeInsets.only(right: 4, top: 4),
                                    child: Chip(
                                      label: Text(
                                        tech,
                                        style: TextStyle(
                                            fontSize: isSmallCard ? 8 : 10),
                                      ),
                                      padding: EdgeInsets.zero,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 4),
                        // Buttons
                        if (githubUrl != null || demoUrl != null)
                          SizedBox(
                            height: isSmallCard ? 32 : 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (githubUrl != null)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: FilledButton.icon(
                                        onPressed: () => _launchUrl(githubUrl!),
                                        icon: Icon(Icons.code,
                                            size: isSmallCard ? 16 : 20),
                                        label: Text(
                                          'Code',
                                          style: TextStyle(
                                              fontSize: isSmallCard ? 10 : 12),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (demoUrl != null)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: FilledButton.tonalIcon(
                                        onPressed: () => _launchUrl(demoUrl!),
                                        icon: Icon(Icons.launch,
                                            size: isSmallCard ? 16 : 20),
                                        label: Text(
                                          'View Page',
                                          style: TextStyle(
                                              fontSize: isSmallCard ? 10 : 12),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
