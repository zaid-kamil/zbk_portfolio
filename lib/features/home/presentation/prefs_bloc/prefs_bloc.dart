import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'prefs_event.dart';
part 'prefs_state.dart';

class PrefsBloc extends Bloc<PrefsEvent, PrefsState> {
  PrefsBloc() : super(PrefsInitial()) {
    on<PrefsEvent>((event, emit) {
      switch(event){
        case OnThemeChangedEvent event:
          emit(PrefsThemeChangedState(event.isDarkMode));
          break;
        case OnColorChangedEvent event:
          emit(PrefsColorChangedState(event.color));
          break;
        case OnFontSizeChangedEvent event:
          emit(PrefsFontSizeChangedState(event.fontSize));
          break;
      }
    });
  }
}
