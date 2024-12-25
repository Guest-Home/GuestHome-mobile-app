import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class CountryCodeSelector extends StatelessWidget {
  const CountryCodeSelector({
    super.key,
    required this.onChange,
  });

  final ValueChanged<CountryCode> onChange;

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      onChanged: (value) => onChange(value),
      initialSelection: 'ET',
      favorite: ['+251', 'ET'],
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
