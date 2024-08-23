import 'package:flutter/material.dart';

import '../../../app/common/widgets/custom_text_form_field.dart';

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
    return Stack(
      children: [
        // The actual text field
        CustomTextFormField(
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
        ),
        // Overlay the animated text on top of the text field
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: !obsecuredText ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: IgnorePointer(
              ignoring: true, // Disable interaction with the overlay
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Text(
                  widget.controller?.text ?? '',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
