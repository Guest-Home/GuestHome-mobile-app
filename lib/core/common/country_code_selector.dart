import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class CountryCodeSelector extends StatelessWidget {
  const CountryCodeSelector({
    super.key,
    required this.onChange,
    required this.onInit,
  });

  final ValueChanged<CountryCode> onChange;
  final ValueChanged<CountryCode> onInit;

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      onChanged: (value) => onChange(value),
      initialSelection: 'ET',
      favorite: ['+251', 'ET'],
      onInit: (value) => onInit(value!),
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
      backgroundColor: Colors.white,
      flagDecoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
    );
  }
}
