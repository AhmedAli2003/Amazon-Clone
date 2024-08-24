import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import 'auth_button_text.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const AuthButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: AuthButtonText(text),
      ),
    );
  }
}
