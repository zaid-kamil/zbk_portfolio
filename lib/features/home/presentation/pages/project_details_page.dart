import 'package:flutter/material.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/media_viewer.dart';
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
                  const SizedBox(height: 18),
                  ProjectInfo(project: project),
                  if (project.videoUrl != null ||
                      project.screenshots?.isNotEmpty == true) ...[
                    const SizedBox(height: 18),
                    _buildMediaGallery(context),
                  ],
                  const SizedBox(height: 18),
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

  String? _extractYouTubeId(String url) {
    final regex = RegExp(
      r'^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/|shorts\/|watch\?v=))([^#\&\?]*).*',
    );
    final match = regex.firstMatch(url);
    return match?.group(1);
  }

  Widget _buildMediaGallery(BuildContext context) {
    final List<MediaItem> mediaItems = [
      if (project.videoUrl != null)
        MediaItem(
          type: MediaType.video,
          url: project.videoUrl!,
          thumbnailUrl:
              'https://img.youtube.com/vi/${_extractYouTubeId(project.videoUrl!)}/0.jpg',
        ),
      ...(project.screenshots ?? []).map(
        (screenshot) => MediaItem(
          type: MediaType.image,
          url: screenshot,
          thumbnailUrl: screenshot,
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gallery',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: mediaItems.length,
            separatorBuilder: (context, _) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final item = mediaItems[index];
              return GestureDetector(
                onTap: () => _showMediaViewer(context, mediaItems, index),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.thumbnailUrl,
                        fit: BoxFit.cover,
                        width: 300,
                        height: 200,
                      ),
                    ),
                    if (item.type == MediaType.video)
                      Positioned.fill(
                        bottom: 80,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.play_circle_outline,
                            color: Colors.white,
                            size: 64,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showMediaViewer(
      BuildContext context, List<MediaItem> items, int initialIndex) {
    showDialog(
      context: context,
      builder: (context) => MediaViewer(
        items: items,
        initialIndex: initialIndex,
      ),
    );
  }
}
