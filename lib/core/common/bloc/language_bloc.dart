import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc()
      : super(LanguageState(
            selectedLanguage: AppLocal.english, locale: Locale('en', 'US'))) {
    on<ChangeAppLocalEvent>((event, emit) async {
      if (event.appLocal != state.selectedLanguage) {
        emit(LanguageState(
            selectedLanguage: event.appLocal,
            locale: getLocale(event.appLocal)));
      }
    });
  }

  Locale getLocale(AppLocal language) {
    switch (language) {
      case AppLocal.english:
        return Locale('en', 'US');
      case AppLocal.amharic:
        return Locale('am', 'ET');
      case AppLocal.afanOromo:
        return Locale('om', 'ET');
    }
  }
}
