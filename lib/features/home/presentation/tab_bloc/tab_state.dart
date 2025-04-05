part of 'tab_bloc.dart';

@immutable
sealed class TabState {}

final class TabInitial extends TabState {}

final class TabMobileApp extends TabState {}

final class TabDataScience extends TabState {}

final class TabWebApp extends TabState {}

final class TabCertificates extends TabState {}

final class TabPublications extends TabState {}

final class TabAboutMe extends TabState {}