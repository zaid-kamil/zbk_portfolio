import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc;

part 'prefs_event.dart';
part 'prefs_state.dart';

class PrefsBloc extends Bloc<PrefsEvent, PrefsState> {
  PrefsBloc() : super(PrefsColorChangedState(FlexScheme.hippieBlue)) {
    on<OnColorChangedEvent>((event, emit) {
      // Check if we're already using this color to avoid unnecessary updates
      if (state is PrefsColorChangedState) {
        final currentState = state as PrefsColorChangedState;
        if (currentState.color == event.color) {
          return; // Don't emit if color hasn't changed
        }
        emit(PrefsColorChangedState(event.color,
            themeMode: currentState.themeMode));
      } else {
        emit(PrefsColorChangedState(event.color));
      }
    });

    on<OnThemeToggleEvent>((event, emit) {
      if (state is PrefsColorChangedState) {
        final currentState = state as PrefsColorChangedState;
        final newThemeMode = currentState.themeMode == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
        emit(PrefsColorChangedState(currentState.color,
            themeMode: newThemeMode));
      }
    });
  }
}
