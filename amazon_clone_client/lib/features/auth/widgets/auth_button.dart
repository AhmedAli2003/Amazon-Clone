import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../controllers/auth_controller.dart';
import 'auth_button_text.dart';

class AuthButton extends ConsumerWidget {
  final VoidCallback onTap;
  final String text;
  const AuthButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(authLoadingProvider);
    return InkWell(
      onTap: loading ? null : onTap,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: loading
            ? const CircularProgressIndicator(
                color: AppColors.backgroundColor,
              )
            : AuthButtonText(text),
      ),
    );
  }
}
