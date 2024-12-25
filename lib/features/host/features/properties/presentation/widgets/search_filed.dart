import 'package:flutter/material.dart';
import '../../../../../../config/color/color.dart';

class searchField extends StatelessWidget {
  const searchField({
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
          hintText: "Search",
          suffixIcon: Icon(Icons.search),
          hintStyle: TextStyle(fontSize: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ));
  }
}
