import 'package:flutter/material.dart';
import 'package:zbk_portfolio/features/home/data/project_loader.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/project_card.dart';

class DataScienceAiContent extends StatefulWidget {
  const DataScienceAiContent({super.key});

  @override
  State<DataScienceAiContent> createState() => _DataScienceAiContentState();
}

class _DataScienceAiContentState extends State<DataScienceAiContent> {
  final _projectLoader = ProjectLoader();
  List<Project> _projects = [];
  bool _isLoading = true;
  String _selectedCategory = 'All';
  int _currentPage = 0;
  final int _projectsPerPage = 6;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    setState(() {
      _isLoading = true;
    });

    final projects = await _projectLoader.loadProjects();
    final dataProjects = projects
        .where((p) => p.category == ProjectCategory.dataScience)
        .toList();

    setState(() {
      _projects = dataProjects;
      _isLoading = false;
    });
  }

  List<String> get _categories {
    final Set<String> categories = {'All'};
    for (final project in _projects) {
      categories.addAll(project.technologies);
    }
    return categories.toList()..sort();
  }

  List<Project> get _filteredProjects {
    if (_selectedCategory == 'All') {
      return _projects;
    }
    return _projects
        .where((project) => project.technologies.contains(_selectedCategory))
        .toList();
  }

  List<Project> get _paginatedProjects {
    final startIndex = _currentPage * _projectsPerPage;
    final endIndex = startIndex + _projectsPerPage;

    if (startIndex >= _filteredProjects.length) {
      return [];
    }

    if (endIndex > _filteredProjects.length) {
      return _filteredProjects.sublist(startIndex);
    }

    return _filteredProjects.sublist(startIndex, endIndex);
  }

  int get _pageCount => (_filteredProjects.length / _projectsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data Science & AI Projects',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),

          // Category filter
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = _categories[index];
                return ChoiceChip(
                  label: Text(category),
                  selected: category == _selectedCategory,
                  onSelected: (_) {
                    setState(() {
                      _selectedCategory = category;
                      _currentPage = 0; // Reset to first page
                    });
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Projects grid
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredProjects.isEmpty
                    ? const Center(
                        child: Text('No projects found in this category'))
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;
                          final crossAxisCount = width > 1200
                              ? 4
                              : width > 800
                                  ? 3
                                  : 1;
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: width / crossAxisCount,
                                    childAspectRatio: 0.75,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _paginatedProjects.length,
                            itemBuilder: (context, index) {
                              final project = _paginatedProjects[index];
                              return ProjectCard(
                                title: project.title,
                                description: project.description,
                                imageUrl: project.imageUrl ?? '',
                                technologies: project.technologies,
                                githubUrl: project.githubUrl,
                                demoUrl: project.url,
                              );
                            },
                          );
                        },
                      ),
          ),

          // Pagination controls
          if (_pageCount > 1)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: _currentPage > 0
                        ? () => setState(() => _currentPage--)
                        : null,
                  ),
                  Text('${_currentPage + 1} / $_pageCount'),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: _currentPage < _pageCount - 1
                        ? () => setState(() => _currentPage++)
                        : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
