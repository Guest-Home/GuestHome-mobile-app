import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomMaterialLocalizations extends DefaultMaterialLocalizations {
  // Provide your custom translations or methods here
}

class CustomMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'om';
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return SynchronousFuture<MaterialLocalizations>(
        CustomMaterialLocalizations());
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}



class CustomCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const CustomCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'om'; // Support for Oromo locale
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    return SynchronousFuture<CupertinoLocalizations>(
        CustomCupertinoLocalizations());
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}

class CustomCupertinoLocalizations extends DefaultCupertinoLocalizations {
  @override
  String get alertDialogLabel => "Custom Alert in Oromo";

}
