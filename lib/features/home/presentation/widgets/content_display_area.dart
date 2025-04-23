import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbk_portfolio/features/home/data/local_project_datasource.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';
import 'package:zbk_portfolio/features/home/presentation/pages/project_details_page.dart';
import 'package:zbk_portfolio/features/home/presentation/project_bloc/project_details_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/category_filter_chips.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/certificate_card.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/project_card.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/publication_container.dart';
import 'package:zbk_portfolio/features/home/utils/display_utils.dart';

import 'about_me_container.dart';

class ContentDisplayArea extends StatefulWidget {
  final ProjectCategory category;

  const ContentDisplayArea({super.key, required this.category});

  @override
  State<ContentDisplayArea> createState() => _ContentDisplayAreaState();
}

class _ContentDisplayAreaState extends State<ContentDisplayArea> {
  final _localDataSource = LocalProjectDataSource();
  late Future<List<Project>> _projectsFuture;
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _projectsFuture = _loadProjects();
  }

  @override
  void didUpdateWidget(ContentDisplayArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      setState(() {
        _selectedCategory = 'All';
        _projectsFuture = _loadProjects();
      });
    }
  }

  Future<List<Project>> _loadProjects() =>
      _localDataSource.getProjectsByCategory(widget.category);

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        DisplayUtils.getCategoryTitle(widget.category),
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }

  Widget _buildProjectGrid(List<Project> allProjects, BuildContext context) {
    // Get filtered projects
    final filteredProjects = DisplayUtils.getFilteredProjects(
      allProjects,
      _selectedCategory,
    );

    return LiveSliverGrid(
      controller: ScrollController(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: DisplayUtils.getGridCount(context),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 450,
      ),
      itemCount: filteredProjects.length,
      // Using AnimationBuilder with Cached projections for better performance
      itemBuilder: (context, i, animation) {
        final project = filteredProjects[i]; // Cache the project reference

        return ScaleTransition(
          scale: animation,
          child: ProjectCard(
            title: project.title,
            description: project.description,
            imageUrl: project.imageUrl ?? '',
            technologies: project.technologies,
            demoUrl: project.url,
            githubUrl: project.githubUrl,
            onTap: () {
              context
                  .read<ProjectDetailsBloc>()
                  .add(ShowProjectDetails(project));
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 100),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ProjectDetailsPage(project: project),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity:
                          animation.drive(CurveTween(curve: Curves.easeOut)),
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildContent(List<Project> projects, ThemeData theme) {
    switch (widget.category) {
      case ProjectCategory.aboutMe:
        return Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            Expanded(child: AboutMeContainer()),
          ],
        );
      case ProjectCategory.certificates:
        return Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            Expanded(
              child: CustomScrollView(
                controller: ScrollController(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: _buildCertificateGrid(
                      projects,
                      context,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case ProjectCategory.publications:
        return Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            Expanded(child: PublicationContainer()),
          ],
        );
      default:
        return Column(
          children: [
            _buildHeader(context),
            CategoryFilterChips(
              categories: DisplayUtils.getCategories(projects),
              selectedCategory: _selectedCategory,
              onCategorySelected: (category) => setState(() {
                _selectedCategory = category;
              }),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: CustomScrollView(
                controller: ScrollController(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: _buildProjectGrid(projects, context),
                  ),
                ],
              ),
            ),
          ],
        );
    }
  }

  Widget _buildCertificateGrid(
      List<Project> allProjects, BuildContext context) {
    // Get filtered projects
    final filteredProjects = DisplayUtils.getFilteredProjects(
      allProjects,
      _selectedCategory,
    );

    return LiveSliverGrid(
      controller: ScrollController(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: DisplayUtils.getGridCount(context),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 300,
      ),
      itemCount: filteredProjects.length,
      itemBuilder: (context, i, animation) => ScaleTransition(
        scale: animation,
        child: CertificateCard(
          title: filteredProjects[i].title,
          issuedBy: filteredProjects[i].description,
          credentialUrl: filteredProjects[i].url,
          imageUrl: filteredProjects[i].imageUrl ?? '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Project>>(
      future: _projectsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return _buildContent(snapshot.data!, Theme.of(context));
      },
    );
  }
}
