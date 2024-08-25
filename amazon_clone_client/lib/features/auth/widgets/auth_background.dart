import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Image.asset(
            AppAssets.logo,
            height: 180,
            width: double.infinity,
          ),
          const Text(
            'Welcome to ShopEase! Find everything you need, all in one place. From the latest tech gadgets to everyday essentials.',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
