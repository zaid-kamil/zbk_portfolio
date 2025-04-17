import 'package:flutter/material.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';

const int projectsPerPage = 8;

class DisplayUtils {
  static List<String> getCategories(List<Project> projects) {
    return {'All', ...projects.expand((p) => p.technologies)}.toList()..sort();
  }

  static List<Project> getFilteredAndPaginatedProjects(
    List<Project> projects,
    String selectedCategory,
    int currentPage,
  ) {
    final filtered = selectedCategory == 'All'
        ? projects
        : projects
            .where((p) => p.technologies.contains(selectedCategory))
            .toList();

    final startIndex = currentPage * projectsPerPage;
    return filtered.skip(startIndex).take(projectsPerPage).toList();
  }

  static int getPageCount(List<Project> projects, String selectedCategory) {
    final filteredCount = selectedCategory == 'All'
        ? projects.length
        : projects
            .where((p) => p.technologies.contains(selectedCategory))
            .length;
    return (filteredCount / projectsPerPage).ceil();
  }

  static int getGridCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 800) return 1;
    if (width < 1400) return 2;
    return 4;
  }

  static String getCategoryTitle(ProjectCategory category) {
    return switch (category) {
      ProjectCategory.webApp => 'Web Apps',
      ProjectCategory.mobileApp => 'Mobile Apps',
      ProjectCategory.dataScience => 'Data Science',
      ProjectCategory.certificates => 'Certificates',
      ProjectCategory.publications => 'Publications',
      ProjectCategory.aboutMe => 'About Me',
    };
  }

  static int getTotalItemCount(
      List<Project> projects, String selectedCategory) {
    return selectedCategory == 'All'
        ? projects.length
        : projects
            .where((p) => p.technologies.contains(selectedCategory))
            .length;
  }

  static List<Project> getFilteredProjects(
      List<Project> projects, String selectedCategory) {
    if (selectedCategory == 'All') {
      return projects;
    }
    return projects
        .where((project) => project.technologies.contains(selectedCategory))
        .toList();
  }
}
