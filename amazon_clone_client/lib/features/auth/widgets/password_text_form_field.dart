import 'package:flutter/material.dart';

import '../../../core/common/widgets/custom_text_form_field.dart';

class PasswordTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String? value)? validator;
  final void Function(String)? onChanged;
  const PasswordTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.validator,
    this.onChanged,
  });

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool obsecuredText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: obsecuredText,
      labelText: 'Password',
      hintText: 'Enter a strong password...',
      prefexIcon: const Icon(Icons.password_rounded),
      suffixIcon: IconButton(
        onPressed: () => setState(() => obsecuredText = !obsecuredText),
        icon: Icon(obsecuredText ? Icons.visibility_off_rounded : Icons.visibility_rounded),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
