part of 'project_details_bloc.dart';

@immutable
sealed class ProjectDetailsState {}

final class ProjectDetailsInitial extends ProjectDetailsState {}

class ProjectDetailsLoading extends ProjectDetailsState {}

class ProjectDetailsShowing extends ProjectDetailsState {
  final Project project;

  ProjectDetailsShowing(this.project);
}

class ProjectDetailsError extends ProjectDetailsState {
  final String errorMessage;

  ProjectDetailsError(this.errorMessage);
}

