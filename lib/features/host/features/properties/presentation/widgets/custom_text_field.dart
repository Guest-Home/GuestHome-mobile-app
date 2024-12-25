import 'package:flutter/material.dart';

import '../../../../../../config/color/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.surfixIcon,
    required this.onTextChnage,
    required this.isMultiLine,
    required this.textInputType,
    this.prifixIcon,
  });

  final String hintText;
  final Widget? surfixIcon;
  final ValueChanged<String> onTextChnage;
  final bool isMultiLine;
  final TextInputType textInputType;
  final Widget? prifixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: textInputType,
        minLines: 1,
        maxLines: isMultiLine ? null : 1,
        onChanged: (value) => onTextChnage(value),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prifixIcon,
          suffixIcon: surfixIcon,
          hintStyle: TextStyle(fontSize: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorConstant.cardGrey),
          ),
        ));
  }
}
