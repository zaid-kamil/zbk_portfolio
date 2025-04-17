import 'package:flutter/material.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/project_info.dart';

class FancyCard extends StatelessWidget {
  const FancyCard({
    super.key,
    required this.image,
    required this.title,
    required this.onCardPressed,
  });

  final VoidCallback onCardPressed;
  final Image image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 250,
              height: 250,
              child: image,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            OutlinedButton(
              child: const Text("Learn more"),
              onPressed: onCardPressed,
            ),
          ],
        ),
      ),
    );
  }
}

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
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: constraints.maxWidth > 1200
              ? _buildWideLayout()
              : constraints.maxWidth > 600
                  ? _buildMediumLayout()
                  : _buildNarrowLayout(),
        );
      }),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: ProjectInfo(project: project),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 2,
          child: ProjectCarousal(project: project),
        ),
      ],
    );
  }

  Widget _buildMediumLayout() {
    return Column(
      children: [
        Expanded(
          child: ProjectCarousal(project: project),
        ),
        const SizedBox(height: 24),
        ProjectInfo(project: project),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          SizedBox(
            height: 400, // Fixed height for carousel on mobile
            child: ProjectCarousal(project: project),
          ),
          ProjectInfo(project: project),
        ],
      ),
    );
  }
}

class ProjectCarousal extends StatelessWidget {
  final Project project;

  const ProjectCarousal({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (project.imageUrl != null) ...[
          Expanded(
            child: Hero(
              tag: 'project-image-${project.title.hashCode}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InteractiveViewer(
                  boundaryMargin: const EdgeInsets.all(20.0),
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.network(
                    project.imageUrl!,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(Icons.error_outline, size: 48),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        if (project.screenshots?.isNotEmpty ?? false) ...[
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: project.screenshots!.length,
              separatorBuilder: (context, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    project.screenshots![index],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }


}
