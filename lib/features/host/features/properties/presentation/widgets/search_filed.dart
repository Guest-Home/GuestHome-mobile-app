import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../config/color/color.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.onTextChnage,
  });

  final ValueChanged<String> onTextChnage;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) => onTextChnage(value),
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstant.cardGrey,
          hintText: tr('Search properties'),
          suffixIcon: Icon(Icons.search),
          hintStyle: TextStyle(fontSize: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ));
  }
}
