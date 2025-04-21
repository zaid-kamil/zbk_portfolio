import 'package:flutter/material.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/lightbox_view.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/project_info.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 600,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeader(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  ProjectInfo(project: project),
                  if (project.screenshots?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 48),
                    _buildScreenshots(context),
                    const SizedBox(height: 48),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (project.imageUrl != null) ...[
          Hero(
            tag: 'project-image-${project.title.hashCode}',
            child: Image.network(
              project.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Theme.of(context).colorScheme.onErrorContainer,
                child: const Center(
                  child: Icon(Icons.image_not_supported, size: 48),
                ),
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Theme.of(context).colorScheme.primaryContainer
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildScreenshots(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Screenshots',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: project.screenshots!.length,
            separatorBuilder: (context, _) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _showLightbox(context, index),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    project.screenshots![index],
                    fit: BoxFit.cover,
                    width: 300,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showLightbox(BuildContext context, int initialIndex) {
    showDialog(
      context: context,
      builder: (context) => LightboxView(
        images: project.screenshots!,
        initialIndex: initialIndex,
      ),
    );
  }
}
