import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/common/utils/ui_functions.dart';
import '../../core/constants/app_assets.dart';
import '../../core/router/app_routes.dart';
import '../auth/repos/auth_repo.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(milliseconds: 100), () {
      setState(() {
        a = !a;
      });
    });
    final before = DateTime.now().millisecondsSinceEpoch;
    ref.read(authRepoProvider).checkAccessToken().then((response) {
      final milliseconds = DateTime.now().millisecondsSinceEpoch - before;
      if (milliseconds > 1200) {
        if (response.$1 != null) {
          final failure = response.$1!;
          debugPrint(failure.toString());
          if (failure.code < 1) {
            GoRouter.of(context).goNamed(AppRoutes.auth.name);
          } else {
            showSnackBar(context, failure.message);
            GoRouter.of(context).goNamed(AppRoutes.auth.name);
          }
        } else {
          GoRouter.of(context).goNamed(AppRoutes.home.name);
        }
      } else {
        Future.delayed(Duration(milliseconds: 1200 - milliseconds), () {
          if (response.$1 != null) {
            final failure = response.$1!;
            debugPrint(failure.toString());
            if (failure.code < 1) {
              GoRouter.of(context).goNamed(AppRoutes.auth.name);
            } else {
              showSnackBar(context, failure.message);
              GoRouter.of(context).goNamed(AppRoutes.auth.name);
            }
          } else {
            GoRouter.of(context).goNamed(AppRoutes.home.name);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  bool a = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 1200),
            curve: Curves.fastLinearToSlowEaseIn,
            width: a ? width : 0,
            height: double.infinity,
            color: Colors.white,
          ),
          Center(
            child: Image.asset(AppAssets.logo),
          ),
        ],
      ),
    );
  }
}
