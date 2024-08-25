import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_keys.dart';

final sharedPreferencesManagerProvider = Provider<SharedPreferencesManager>(
  (ref) => throw UnimplementedError(),
);

class SharedPreferencesManager {
  final SharedPreferences sp;

  const SharedPreferencesManager(this.sp);

  Future<bool> storeAccessToken(String accessToken) async {
    return await sp.setString(AppKeys.accessToken, accessToken);
  }

  String? getAccessToken() {
    return sp.getString(AppKeys.accessToken);
  }

  Future<bool> storeExpiresIn(String expiresIn) async {
    return await sp.setString(AppKeys.expiresIn, expiresIn);
  }

  String? getExpiresIn() {
    return sp.getString(AppKeys.expiresIn);
  }
}
