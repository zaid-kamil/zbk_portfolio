part of 'prefs_bloc.dart';

@immutable
sealed class PrefsEvent {}

final class OnColorChangedEvent extends PrefsEvent {
  final Color color;

  OnColorChangedEvent(this.color);
}

final class OnThemeToggleEvent extends PrefsEvent {}
