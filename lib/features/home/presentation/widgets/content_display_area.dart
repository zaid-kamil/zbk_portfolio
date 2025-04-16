import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbk_portfolio/features/home/data/local_project_datasource.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';
import 'package:zbk_portfolio/features/home/presentation/pages/project_details_page.dart';
import 'package:zbk_portfolio/features/home/presentation/project_bloc/project_details_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/category_filter_chips.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/project_card.dart';
import 'package:zbk_portfolio/features/home/utils/display_utils.dart';

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
  int _currentPage = 0;
  int _totalItems = 0;

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
        _currentPage = 0;
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

  Widget _buildProjectGrid(
      List<Project> displayProjects, BuildContext context) {
    return LiveSliverGrid(
      controller: ScrollController(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: DisplayUtils.getGridCount(context),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 450,
      ),
      itemCount: displayProjects.length,
      itemBuilder: (context, i, animation) =>
          _buildProjectCard(context, i, animation, displayProjects),
    );
  }

  Widget _buildProjectCard(BuildContext context, int i,
      Animation<double> animation, List<Project> projects) {
    final project = DisplayUtils.getFilteredAndPaginatedProjects(
      projects,
      _selectedCategory,
      _currentPage,
    )[i];

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
          context.read<ProjectDetailsBloc>().add(ShowProjectDetails(project));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProjectDetailsPage(project: project),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaginationDots(int pageCount, Color primaryColor) {
    if (pageCount <= 1) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageCount, (index) {
          return IconButton(
            icon: Icon(
              Icons.circle,
              color: _currentPage == index
                  ? primaryColor
                  : primaryColor.withAlpha(150),
            ),
            onPressed: () => setState(() => _currentPage = index),
          );
        }),
      ),
    );
  }

  Widget _buildContent(List<Project> projects, ThemeData theme) {
    final primaryColor = theme.primaryColorDark;
    final backgroundColor = theme.colorScheme.onPrimary;
    final pageCount = DisplayUtils.getPageCount(projects, _selectedCategory);
    final displayProjects = DisplayUtils.getFilteredAndPaginatedProjects(
      projects,
      _selectedCategory,
      _currentPage,
    );

    _totalItems = DisplayUtils.getTotalItemCount(projects, _selectedCategory);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: primaryColor.withAlpha(150), width: 1),
          left: BorderSide(color: primaryColor.withAlpha(150), width: 1),
          right: BorderSide(color: primaryColor.withAlpha(150), width: 1),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          CategoryFilterChips(
            categories: DisplayUtils.getCategories(projects),
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) => setState(() {
              _selectedCategory = category;
              _currentPage = 0;
            }),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: CustomScrollView(
              controller: ScrollController(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: _buildProjectGrid(displayProjects, context),
                ),
              ],
            ),
          ),
          _buildPaginationDots(pageCount, primaryColor),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      child: FutureBuilder<List<Project>>(
        future: _projectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No projects found.'));
          }

          return _buildContent(snapshot.data!, Theme.of(context));
        },
      ),
    );
  }
}
