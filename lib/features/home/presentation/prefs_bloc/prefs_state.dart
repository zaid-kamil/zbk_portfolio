part of 'prefs_bloc.dart';

@immutable
sealed class PrefsState {}

final class PrefsInitial extends PrefsState {}

// change theme
final class PrefsThemeChangedState extends PrefsState {
  final bool isDarkMode;

  PrefsThemeChangedState(this.isDarkMode);
}

// change color
final class PrefsColorChangedState extends PrefsState {
  final Color color;

  PrefsColorChangedState(this.color);
}

// change font size
final class PrefsFontSizeChangedState extends PrefsState {
  final double fontSize;

  PrefsFontSizeChangedState(this.fontSize);
}