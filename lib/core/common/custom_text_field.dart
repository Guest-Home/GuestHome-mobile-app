import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/color/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.surfixIcon,
      required this.onTextChnage,
      required this.isMultiLine,
      required this.textInputType,
      this.prifixIcon,
      this.validator,
      this.textEditingController,
        this.enabled,
        this.readOnly,
        this.inputFormatter,
      this.intialValue});

  final String hintText;
  final Widget? surfixIcon;
  final ValueChanged<String> onTextChnage;
  final bool isMultiLine;
  final TextInputType textInputType;
  final Widget? prifixIcon;
  final FormFieldValidator<String>? validator;
  final TextEditingController? textEditingController;
  final String? intialValue;
  final bool? enabled;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled??true,
        readOnly:readOnly??false ,
        controller: textEditingController,
        keyboardType: textInputType,
        minLines: 1,
        inputFormatters:inputFormatter,
        initialValue: intialValue,
        maxLines: isMultiLine ? null : 1,
        onChanged: (value) => onTextChnage(value),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: true,
        validator: (value) => validator!(value!),
        cursorColor: ColorConstant.primaryColor,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          prefixIcon: prifixIcon,
          suffixIcon: surfixIcon,
          contentPadding: EdgeInsets.all(15),
          hintStyle:
              TextStyle(fontSize: 13, color: ColorConstant.inActiveColor.withValues(alpha: 0.7)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorConstant.red),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorConstant.cardGrey),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorConstant.cardGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorConstant.primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: ColorConstant.inActiveColor.withValues(alpha: 0.2)),
          ),
        ));
  }
}
