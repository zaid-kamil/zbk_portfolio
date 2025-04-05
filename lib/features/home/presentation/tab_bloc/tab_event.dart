part of 'tab_bloc.dart';

@immutable
sealed class TabEvent {}

// navigation tabs for different sections

// enum TabEvent {
//   androidFlutter,
//   dataScienceAi,
//   certificates,
//   publications,
//   aboutMe,
//   nextPage,
//   prevPage
// }

class OnMobileTabClickedEvent extends TabEvent {
  OnMobileTabClickedEvent();
}

class OnDataScienceTabClickedEvent extends TabEvent {
  OnDataScienceTabClickedEvent();
}

class OnWebTabClickedEvent extends TabEvent {
  OnWebTabClickedEvent();
}

class OnCertificatesTabClickedEvent extends TabEvent {
  OnCertificatesTabClickedEvent();
}

class OnPublicationsTabClickedEvent extends TabEvent {
  OnPublicationsTabClickedEvent();
}

class OnAboutMeTabClickedEvent extends TabEvent {
  OnAboutMeTabClickedEvent();
}