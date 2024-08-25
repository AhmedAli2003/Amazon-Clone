import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final internetCheckerProvider = Provider((ref) => InternetCheckerImpl());

abstract class InternetChecker {
  final InternetConnection internetConnection;
  const InternetChecker(this.internetConnection);
  Future<bool> get hasConnection;
}

class InternetCheckerImpl extends InternetChecker {
  InternetCheckerImpl() : super(InternetConnection());

  @override
  Future<bool> get hasConnection => internetConnection.hasInternetAccess;
}
