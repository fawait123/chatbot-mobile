import 'package:apps_consultation_pregnant/app/core/styles/style_color.dart';
import 'package:flutter/material.dart';

class DefaultTextInput extends StatelessWidget {
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final String? hintText;
  final TextEditingController? controller;

  const DefaultTextInput({super.key, this.textStyle, this.keyboardType, this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle,
      keyboardType: keyboardType,
      validator: (val) {
        if(val == null || val.isEmpty) {
          return 'Please fill in correctly!';
        }
      },
      obscureText: keyboardType == TextInputType.visiblePassword ? true : false,
      controller: controller,
      cursorColor: CustomColor.greyColor,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: textStyle,
        fillColor: CustomColor.whiteColor,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                18),
            borderSide: BorderSide(
                color: CustomColor.greyColor,
                width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                18),
            borderSide: BorderSide(
                color: CustomColor.greyColor,
                width: 1)),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: CustomColor.greyColor,
              width: 1),
          borderRadius: BorderRadius.circular(
              18),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: CustomColor.greyColor,
              width: 1),
          borderRadius: BorderRadius.circular(
              18),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: CustomColor.greyColor,
              width: 1),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}
