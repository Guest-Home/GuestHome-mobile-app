part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();
}

class ChangeAppLocalEvent extends LanguageEvent{
  final AppLocal appLocal;

  @override
  List<Object?> get props =>[appLocal];
  const ChangeAppLocalEvent(this.appLocal);
}