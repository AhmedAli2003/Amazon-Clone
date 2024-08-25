import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app/amazon_app.dart';
import 'core/common/utils/shared_preferences_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesManagerProvider.overrideWith(
          (ref) => SharedPreferencesManager(sharedPreferences),
        ),
      ],
      child: const AmazonApp(),
    ),
  );
}
