import 'package:zbk_portfolio/features/home/domain/project.dart';

abstract class ProjectRepo {
  Future<List<Project>> getProjectsByCategory(ProjectCategory category);

  Future<void> addProject(Project project);

  Future<void> deleteProject(String id);

  Future<void> updateProject(Project project);

  Future<List<Project>> getAllProjects();
}
