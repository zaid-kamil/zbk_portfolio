part of 'prefs_bloc.dart';

@immutable
sealed class PrefsEvent {}

// change theme
class OnThemeChangedEvent extends PrefsEvent {
  final bool isDarkMode;

  OnThemeChangedEvent(this.isDarkMode);
}
// change color
class OnColorChangedEvent extends PrefsEvent {
  final Color color;

  OnColorChangedEvent(this.color);
}
// change font size
class OnFontSizeChangedEvent extends PrefsEvent {
  final double fontSize;

  OnFontSizeChangedEvent(this.fontSize);
}