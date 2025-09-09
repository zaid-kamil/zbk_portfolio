import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
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
        return Tilt(
          tiltConfig: const TiltConfig(angle: 20),
          childLayout: ChildLayout(
            outer: [
              // Only the tag chip uses parallax now
              Positioned(
                top: 10,
                right: 10,
                child: TiltParallax(
                  size: const Offset(-30, -30),
                  child: _buildTagChip(context),
                ),
              ),
            ],
          ),
          child: _buildBaseCard(context, isSmallCard),
        );
      },
    );
  }

  // Base card without the image + tag (they are parallax overlays now)
  Widget _buildBaseCard(BuildContext context, bool isSmallCard) {
    const double imageHeight = 220;
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      shadowColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image now part of base card (no parallax)
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Hero(
                tag: 'project-image-${title.hashCode}',
                child: Image.asset(
                  imageUrl,
                  height: imageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => _buildFallbackImage(context),
                ),
              ),
            ),
            Expanded(
              child: _buildContentSection(context, isSmallCard),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagChip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        technologies.isNotEmpty ? technologies.first : 'Project',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildFallbackImage(BuildContext context) => Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
          ),
        ),
      );

  Widget _buildContentSection(BuildContext context, bool isSmallCard) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context, isSmallCard),
          const SizedBox(height: 8),
          _buildDescription(context, isSmallCard),
          const SizedBox(height: 8),
          _buildTechnologies(context, isSmallCard),
          const SizedBox(height: 8),
          if (githubUrl != null || demoUrl != null)
            _buildActionButtons(context, isSmallCard),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, bool isSmallCard) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: isSmallCard ? 14 : 16,
        color: Theme.of(context).colorScheme.primary,
        letterSpacing: 0.5,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDescription(BuildContext context, bool isSmallCard) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: isSmallCard ? 12 : 14,
                height: 1.3,
              ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildTechnologies(BuildContext context, bool isSmallCard) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: technologies
          .map((tech) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getRandomColor(context),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  tech,
                  style: TextStyle(
                    fontSize: isSmallCard ? 8 : 10,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Color _getRandomColor(BuildContext context) {
    final colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.tertiary,
    ];
    return colors[title.hashCode % colors.length];
  }

  Widget _buildActionButtons(BuildContext context, bool isSmallCard) {
    return SizedBox(
      height: isSmallCard ? 38 : 46,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (githubUrl != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: OutlinedButton.icon(
                  onPressed: () => _launchUrl(githubUrl!),
                  icon: Icon(
                    Icons.code,
                    size: isSmallCard ? 16 : 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  label: Text(
                    'Code',
                    style: TextStyle(
                      fontSize: isSmallCard ? 10 : 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          if (demoUrl != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: OutlinedButton.icon(
                  onPressed: () => _launchUrl(demoUrl!),
                  icon: Icon(
                    Icons.rocket_launch,
                    size: isSmallCard ? 16 : 20,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  label: Text(
                    'Demo',
                    style: TextStyle(
                      fontSize: isSmallCard ? 10 : 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
