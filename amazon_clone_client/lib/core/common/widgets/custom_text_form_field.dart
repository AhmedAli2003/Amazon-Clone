import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String? value)? validator;
  final void Function(String)? onChanged;
  final Widget? prefex;
  final Widget? prefexIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextStyle? style;
  const CustomTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.validator,
    this.hintText,
    this.prefex,
    this.prefexIcon,
    this.suffix,
    this.suffixIcon,
    this.labelText,
    this.onChanged,
    this.style,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      style: style,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefix: prefex,
        prefixIcon: prefexIcon,
        suffix: suffix,
        suffixIcon: suffixIcon,
        errorMaxLines: 3,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.inputBorderColor,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.inputBorderColor,
          ),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
