import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';
import 'package:zbk_portfolio/features/home/utils/display_utils.dart';

class ProjectInfo extends StatefulWidget {
  final Project project;

  const ProjectInfo({super.key, required this.project});

  @override
  State<ProjectInfo> createState() => _ProjectInfoState();
}

class _ProjectInfoState extends State<ProjectInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: Card.filled(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _projectCategory(widget.project.category),
              const SizedBox(height: 24),
              _projectTitle(context, widget.project.title),
              const SizedBox(height: 24),
              _pojectChips(widget.project.technologies),
              const SizedBox(height: 24),
              _projectDescription(context, widget.project.description),
              const SizedBox(height: 24),
              _projectDifficulty(widget.project.difficultyLevel),
              const SizedBox(height: 24),
              _projectButtons(widget.project),
            ],
          ),
        ),
      ),
    );
  }

  Widget _projectCategory(ProjectCategory category) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        DisplayUtils.getCategoryTitle(category),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _projectTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _pojectChips(List<String> technologies) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: technologies.map((tech) {
        return Chip(
          label: Text(tech),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        );
      }).toList(),
    );
  }

  Widget _projectDescription(BuildContext context, String description) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _projectDifficulty(int difficulty) {
    return Row(
      children: List.generate(
        10,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Icon(
            Icons.handyman_sharp,
            color: index < difficulty ? Colors.redAccent : Colors.grey.shade300,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _projectButtons(Project project) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (project.url != null) ...[
          FilledButton.icon(
            icon: const Icon(Icons.launch),
            onPressed: () => launchUrl(Uri.parse(project.url!)),
            label: const Text('Live Demo'),
          ),
          const SizedBox(width: 16),
        ],
        if (project.githubUrl != null)
          OutlinedButton.icon(
            icon: const Icon(Icons.code),
            onPressed: () => launchUrl(Uri.parse(project.githubUrl!)),
            label: const Text('View Code'),
          ),
      ],
    );
  }
}
