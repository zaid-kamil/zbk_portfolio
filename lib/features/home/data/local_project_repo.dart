
// local project repo

import 'package:zbk_portfolio/features/home/domain/project.dart';

import '../domain/project_repo.dart';
import 'local_project_datasource.dart';

class LocalProjectRepo implements ProjectRepo {
  final LocalProjectDataSource localProjectDataSource;

  LocalProjectRepo(this.localProjectDataSource);

  @override
  Future<void> addProject(Project project) {
    return localProjectDataSource.addProject(project);
  }

  @override
  Future<void> deleteProject(String id) {
    return localProjectDataSource.deleteProject(id);
  }

  @override
  Future<List<Project>> getProjectsByCategory(ProjectCategory category) {
    return localProjectDataSource.getProjectsByCategory(category);
  }

  @override
  Future<void> updateProject(Project project) {
    return localProjectDataSource.updateProject(project);
  }

  @override
  Future<List<Project>> getAllProjects() {
    return localProjectDataSource.getAllProjects();
  }

}

