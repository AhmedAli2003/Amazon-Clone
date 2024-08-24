import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../widgets/auth_background.dart';
import '../widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.greyBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            AuthBackground(),
            AuthForm(),
          ],
        ),
      ),
    );
  }
}
