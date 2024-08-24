import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  const AuthTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    );
  }
}
