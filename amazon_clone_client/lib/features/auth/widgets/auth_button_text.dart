import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

class AuthButtonText extends StatelessWidget {
  final String text;
  const AuthButtonText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.backgroundColor,
      ),
    );
  }
}
