part of 'project_details_bloc.dart';

@immutable
sealed class ProjectDetailsEvent {}

class ShowProjectDetails extends ProjectDetailsEvent {
  final Project project;

  ShowProjectDetails(this.project);
}
