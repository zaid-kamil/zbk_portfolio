import 'package:zbk_portfolio/features/home/data/project_loader.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';

class LocalProjectDataSource {
  Future<void> addProject(Project project) async {}

  Future<void> deleteProject(String id) async {}

  Future<List<Project>> getProjectsByCategory(ProjectCategory category) async {
    return ProjectLoader().loadProjects().then((projects) {
      return projects
          .where((project) => project.category == category)
          .toList();
    });
  }

  Future<void> updateProject(Project project) async {}

  Future<List<Project>> getAllProjects() async {
    return ProjectLoader().loadProjects();
  }
}


