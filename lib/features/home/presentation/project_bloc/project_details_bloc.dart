import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';

part 'project_details_event.dart';
part 'project_details_state.dart';

class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  ProjectDetailsBloc() : super(ProjectDetailsInitial()) {
    on<ProjectDetailsEvent>((event, emit) {
      switch (event) {
        case ShowProjectDetails showProjectDetails:
          emit(ProjectDetailsLoading());
          try {
            emit(ProjectDetailsShowing(showProjectDetails.project));
          } catch (e) {
            emit(ProjectDetailsError(e.toString()));
          }
          break;
      }
    });
  }
}
