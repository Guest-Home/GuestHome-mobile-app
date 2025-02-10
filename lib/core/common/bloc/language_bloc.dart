import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends HydratedBloc<LanguageEvent, LanguageState> {
  LanguageBloc()
      : super(LanguageState(
            selectedLanguage: AppLocal.english, locale: Locale('en', 'US'))) {
    on<ChangeAppLocalEvent>((event, emit) async {
      if (event.appLocal != state.selectedLanguage) {
        final newState = LanguageState(
          selectedLanguage: event.appLocal,
          locale: getLocale(event.appLocal),
        );
        emit(newState);
      }
    });
    on<ChangeAppLocalSetting>((event, emit) async {
      if (event.appLocal != state.selectedLanguage.name) {
        emit(LanguageState(
            selectedLanguage: getLocaleFromString(event.appLocal)!,
            locale: getLocale(getLocaleFromString(event.appLocal)!)));
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

  AppLocal? getLocaleFromString(String language) {
    switch (language) {
      case 'english':
        return AppLocal.english;
      case 'amharic':
        return AppLocal.amharic;
      case 'afanOromo':
        return AppLocal.afanOromo;
      default:
        return AppLocal.english;
    }
  }

  @override
  LanguageState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey('selectedLanguage')) {
      final language = getLocaleFromString(json['selectedLanguage']);
      if (language != null) {
       return LanguageState(selectedLanguage: language, locale:getLocale(language));
      }
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    return {"selectedLanguage":state.selectedLanguage.name};

  }
}
