import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabInitial()) {
    on<TabEvent>((event, emit) {
      if (event is OnMobileTabClickedEvent) {
        emit(TabMobileApp());
      } else if (event is OnDataScienceTabClickedEvent) {
        emit(TabDataScience());
      } else if (event is OnWebTabClickedEvent) {
        emit(TabWebApp());
      } else if (event is OnCertificatesTabClickedEvent) {
        emit(TabCertificates());
      } else if (event is OnPublicationsTabClickedEvent) {
        emit(TabPublications());
      } else if (event is OnAboutMeTabClickedEvent) {
        emit(TabAboutMe());
      }
    });
  }
}
