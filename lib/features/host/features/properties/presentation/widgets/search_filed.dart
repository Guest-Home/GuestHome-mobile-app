import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../config/color/color.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.onTextChnage, required this.prifixIcon,required this.isActive, this.surfixIcon
  });

  final ValueChanged<String> onTextChnage;
  final Widget prifixIcon;
  final Widget? surfixIcon;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) => onTextChnage(value),
        enabled:isActive?true: false,
        autofocus: isActive?true:false,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstant.cardGrey.withValues(alpha: 0.8),
          hintText: tr('Search properties'),
          prefixIcon: prifixIcon,
          hintStyle: TextStyle(fontSize: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:BorderSide(color: ColorConstant.cardGrey)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:BorderSide(color: ColorConstant.primaryColor.withValues(alpha: 0.7))
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:BorderSide(color: ColorConstant.primaryColor..withValues(alpha: 0.7))
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:BorderSide.none
          ),

        ));
  }
}
