import 'package:flutter/material.dart';

import '../../../app/common/functions/validators.dart';
import '../../../app/common/widgets/custom_text_form_field.dart';
import '../../../app/constants/app_assets.dart';
import '../../../app/theme/app_colors.dart';
import '../widgets/password_text_form_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late final FocusNode nameFocusNode;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;

  late final PageController pageController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    pageController = PageController()
      ..addListener(() {
        setState(() {
          progress = pageController.page ?? 0;
        });
      });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    pageController.dispose();
    super.dispose();
  }

  bool clickedOnce = true;

  void onChange(String? _) {
    if (progress == 0) {
      signInFormKey.currentState?.validate();
    } else {
      signUpFormKey.currentState?.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
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
            ),
            Column(
              children: [
                const Spacer(),
                Container(
                  height: 300 + progress * 70,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: PageView(
                    controller: pageController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Form(
                          key: signInFormKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                CustomTextFormField(
                                  controller: emailController,
                                  focusNode: emailFocusNode,
                                  labelText: 'Email',
                                  hintText: 'Enter your email...',
                                  prefexIcon: const Icon(Icons.email_rounded),
                                  validator: validateEmail,
                                  onChanged: clickedOnce ? null : onChange,
                                ),
                                const SizedBox(height: 12),
                                PasswordTextFormField(
                                  controller: passwordController,
                                  focusNode: passwordFocusNode,
                                  validator: validatePassword,
                                  onChanged: clickedOnce ? null : onChange,
                                ),
                                const SizedBox(height: 12),
                                InkWell(
                                  onTap: () {
                                    if (signInFormKey.currentState?.validate() ?? false) {
                                    } else {}
                                    setState(() => clickedOnce = false);
                                  },
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  child: Container(
                                    width: double.infinity,
                                    height: 48,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.backgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    pageController.animateToPage(
                                      1,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: const Text('Don\'t have an account?'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Form(
                          key: signUpFormKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                CustomTextFormField(
                                  controller: nameController,
                                  focusNode: nameFocusNode,
                                  labelText: 'Username',
                                  hintText: 'Enter your name...',
                                  prefexIcon: const Icon(Icons.person_rounded),
                                  validator: validateUsername,
                                  onChanged: clickedOnce ? null : onChange,
                                ),
                                const SizedBox(height: 12),
                                CustomTextFormField(
                                  controller: emailController,
                                  focusNode: emailFocusNode,
                                  labelText: 'Email',
                                  hintText: 'Enter your email...',
                                  prefexIcon: const Icon(Icons.email_rounded),
                                  validator: validateEmail,
                                  onChanged: clickedOnce ? null : onChange,
                                ),
                                const SizedBox(height: 12),
                                PasswordTextFormField(
                                  controller: passwordController,
                                  focusNode: passwordFocusNode,
                                  validator: validatePassword,
                                  onChanged: clickedOnce ? null : onChange,
                                ),
                                const SizedBox(height: 12),
                                InkWell(
                                  onTap: () {
                                    if (signUpFormKey.currentState?.validate() ?? false) {
                                    } else {}
                                    setState(() => clickedOnce = false);
                                  },
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  child: Container(
                                    width: double.infinity,
                                    height: 48,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.backgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    pageController.animateToPage(
                                      0,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: const Text('Already have an account?'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
