import 'package:flutter/material.dart';
import 'package:zbk_portfolio/features/home/data/local_project_datasource.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/project_card.dart';

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
  final int _projectsPerPage = 8;
  final _gridKey = GlobalKey<SliverAnimatedGridState>();

  Future<List<Project>> _loadProjects() async {
    return await _localDataSource.getProjectsByCategory(widget.category);
  }

  List<String> _getCategories(List<Project> projects) {
    final Set<String> categories = {'All'};
    for (final project in projects) {
      categories.addAll(project.technologies);
    }
    return categories.toList()..sort();
  }

  List<Project> _getFilteredProjects(List<Project> projects) {
    if (_selectedCategory == 'All') {
      return projects;
    }
    return projects
        .where((project) => project.technologies.contains(_selectedCategory))
        .toList();
  }

  List<Project> _getPaginatedProjects(List<Project> projects) {
    final startIndex = _currentPage * _projectsPerPage;
    final endIndex = startIndex + _projectsPerPage;

    if (startIndex >= projects.length) {
      return [];
    }

    if (endIndex > projects.length) {
      return projects.sublist(startIndex);
    }

    return projects.sublist(startIndex, endIndex);
  }

  int _getPageCount(List<Project> projects) {
    return (projects.length / _projectsPerPage).ceil();
  }

  @override
  void initState() {
    super.initState();
    _projectsFuture = _loadProjects();
  }

  @override
  void didUpdateWidget(ContentDisplayArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      _selectedCategory = 'All'; // Reset category filter
      _currentPage = 0; // Reset pagination
      _projectsFuture = _loadProjects(); // Reload projects for new category
    }
  }

  String getNameFromCategory(ProjectCategory category) {
    switch (category) {
      case ProjectCategory.webApp:
        return 'Web Apps';
      case ProjectCategory.mobileApp:
        return 'Mobile Apps';
      case ProjectCategory.dataScience:
        return 'Data Science';
      case ProjectCategory.certificates:
        return 'Certificates';
      case ProjectCategory.publications:
        return 'Publications';
      case ProjectCategory.aboutMe:
        return 'About Me';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Project>>(
      future: _projectsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No projects found.'));
        }

        final projects = snapshot.data!;
        final categories = _getCategories(projects);
        final filteredProjects = _getFilteredProjects(projects);
        final paginatedProjects = _getPaginatedProjects(filteredProjects);
        final pageCount = _getPageCount(filteredProjects);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                getNameFromCategory(widget.category),
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Wrap(
              spacing: 8.0,
              children: [
                for (final category in categories)
                  ChoiceChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? category : 'All';
                        _currentPage = 0; // Reset pagination
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  key: _gridKey,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    mainAxisExtent: 450,
                  ),
                  itemCount: paginatedProjects.length,
                  itemBuilder: (context, index) {
                    final project = paginatedProjects[index];
                    return ProjectCard(
                      title: project.title,
                      description: project.description,
                      imageUrl: project.imageUrl ?? '',
                      technologies: project.technologies,
                      demoUrl: project.url,
                      githubUrl: project.githubUrl,
                    );
                  },
                ),
              ),
            ),
            if (pageCount > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        if (_currentPage > 0) {
                          _currentPage--;
                        }
                      });
                    },
                  ),
                  Text('${_currentPage + 1} / $pageCount'),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      setState(() {
                        if (_currentPage < pageCount - 1) {
                          _currentPage++;
                        }
                      });
                    },
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
