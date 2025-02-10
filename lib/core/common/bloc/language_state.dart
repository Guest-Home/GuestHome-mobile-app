part of 'language_bloc.dart';

enum AppLocal {english,amharic, afanOromo}
class LanguageState extends Equatable {
  final Locale locale;
  final AppLocal selectedLanguage;
  const LanguageState({required this.selectedLanguage, required this.locale});

  LanguageState copyWith({
     Locale? locale,
     AppLocal? selectedLanguage
}){
    return LanguageState(
      locale: locale??this.locale,
      selectedLanguage: selectedLanguage??this.selectedLanguage
    );
}


  @override
  List<Object?> get props =>[selectedLanguage,locale];
}


