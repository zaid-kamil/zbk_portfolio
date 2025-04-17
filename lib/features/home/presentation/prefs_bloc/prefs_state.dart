part of 'prefs_bloc.dart';

@immutable
sealed class PrefsState {}

final class PrefsInitial extends PrefsState {}
// change color
final class PrefsColorChangedState extends PrefsState {
  final Color color;
  final ThemeMode themeMode;

  PrefsColorChangedState(this.color, {this.themeMode = ThemeMode.system});
}
